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
        parsed_data = JSON.generate(data.to_json)
        output, error, status = Open3.capture3("java -jar resources/xlsx-creator/xlsx-creator.jar \"templates/#{form.file_name}\" #{parsed_data}")

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
