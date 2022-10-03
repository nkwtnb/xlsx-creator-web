module Api
  module V1
    class FormController < ActionController::API
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
        base64 = `java -jar resources/xlsx-creator/xlsx-creator.jar "templates/#{form.file_name}" #{parsed_data}`
        # TODO: エラーハンドリング
        return render json: {base64: base64}, status: :ok
      end
    end
  end
end
