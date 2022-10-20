class FormController < ApplicationController
  include Auth
  include FormService
  def create
    begin
      uploaded_file = params[:form_file]
      description = params[:description]
      form_create_service(uploaded_file, description)
      return head :ok
    rescue => e
      p e.message
      return render json: {
        message: e.message
      }, status: :bad_request
    end
  end

  def update
    begin
      uploaded_file = params[:form_file]
      description = params[:description]
      selected_seq = params[:selected_seq]
      is_update_form = params[:is_update_form]
      form_update_service(uploaded_file, description, selected_seq, is_update_form)
      return head :ok
    rescue => e
      p e.message
      return render json: {
        message: e.message
      }, status: :bad_request
    end
  end

  def delete
    user = get_authenticated_user
    if user.nil?
      return redirect_to sign_in_path
    end
    form = Form.where(user_id: user.id, seq: params[:selected_seq]).first
    if form.nil?
      return render json: {message: "ID：#{param[:selected_seq]} の帳票テンプレートが存在しません"}, status: :bad_request
    end
    form.destroy
    return head :ok
  end
end

