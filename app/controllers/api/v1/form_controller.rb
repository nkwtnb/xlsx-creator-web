require "open3"
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
        temp_file_full_path = Rails.root.join("resources", "xlsx-creator", "templates", temp_file_name)
        f = File.open(temp_file_full_path, "w+b")
        f.write(contents.read)
        f.close

        parsed_data = JSON.generate(data.to_json)
        output, error, status = Open3.capture3("java -jar resources/xlsx-creator/xlsx-creator.jar \"templates/#{temp_file_name}\" #{parsed_data}")

        if File.exist?(temp_file_full_path)
          begin
            File.delete(temp_file_full_path)
          rescue => e
            return render json: {message: "帳票作成の後処理でエラーが発生しました"}, status: :bad_request
          end
        end
        if status.exitstatus == STATUS[:NORMAL_END]
          return render json: {base64: output}, status: :ok
        elsif status.exitstatus == STATUS[:TIMEOUT]
          return render json: {message: "帳票作成処理がタイムアウトしました"}, status: :request_timeout
        else
          return render json: {message: "帳票作成処理でエラーが発生しました"}, status: :bad_request
        end
      end

      private
      # https://github.com/NoamB/sorcery/issues/724
      def form_authenticity_token; end
    end
  end
end
