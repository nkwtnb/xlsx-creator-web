require "open3"
require 'base64'

module Api
  module V1
    class FormController < ActionController::API
      STATUS = {
        NORMAL_END: 0,
        ABNORAMAL_END: 1,
        TIMEOUT: 2
      }
      include Auth
      def new
        user = get_authenticated_user_from_api(params)
        if user.nil?
          return head 401
        end
        form_id = params[:formId]
        data = params[:data]
        form = Form.where(user_id: user.id, seq: form_id).first
        if form.nil?
          return render json: {message: "指定の帳票ID: #{form_id} に対応する帳票が存在しません。"}, status: :bad_request
        end
        storage = Storage.new
        file = storage.get(form.file_name)
        contents = file.download
        contents.rewind
        temp_file_name = SecureRandom.uuid + ".xlsx"
        temp_file_full_path = create_temp_path(temp_file_name)
        f = File.open(temp_file_full_path, "w+b")
        f.write(contents.read)
        f.close
        parsed_data = JSON.generate(data.to_json)
        # Excel作成
        excel_base64, e, s = create_excel(temp_file_name, parsed_data)
        if s.exitstatus == STATUS[:TIMEOUT]
          return render json: {message: "帳票作成処理がタイムアウトしました"}, status: :request_timeout
        elsif s.exitstatus != STATUS[:NORMAL_END]
          return render json: {message: "帳票作成処理でエラーが発生しました"}, status: :bad_request
        end
        # Excel形式の場合はここで終了
        body = JSON.parse(request.body.read)
        if ActiveRecord::Type::Boolean.new.cast(body["pdf"]) == false
          return render json: {base64: excel_base64}, status: :ok
        end
        # PDF作成
        xlsx_file_path = create_temp_path(temp_file_name + "_temp.xlsx")
        pdf_file_path = create_temp_path(temp_file_name + "_temp.pdf")
        pdf_base64 = create_pdf(xlsx_file_path, pdf_file_path)
        delete_files([temp_file_full_path, xlsx_file_path, pdf_file_path])
        return render json: {base64: pdf_base64}, status: :ok
      end

      private
      # https://github.com/NoamB/sorcery/issues/724
      def form_authenticity_token; end
      def create_excel(temp_file_name, parsed_data)
        o, e, s = Open3.capture3("java -jar resources/xlsx-creator/xlsx-creator.jar \"templates/#{temp_file_name}\" #{parsed_data} 0")
        return o, e, s
      end
      def create_pdf(xlsx_file_path, pdf_file_path)
        result = ""
        if File.exist?(xlsx_file_path)
          o, e, s = Open3.capture3("unoconv -f pdf #{xlsx_file_path}")
          if s.exitstatus == 0
            # Excelファイルをバイナリモードで読み込む
            excel_data = File.binread(pdf_file_path)
            # ExcelデータをBase64エンコードする
            result = Base64.strict_encode64(excel_data)
          end
        end
        return result
      end
      def create_temp_path(temp_file_name)
        Rails.root.join("resources", "xlsx-creator", "templates", temp_file_name)
      end

      def delete_files(files)
        files.each do |file_path|
          if File.exist?(file_path)
            File.delete(file_path)
          end
        end
      end
    end
  end
end
