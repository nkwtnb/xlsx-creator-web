class FormController < ApplicationController
  include Auth
  include FormService
  def create
    begin
      uploaded_file = params[:form_file]
      description = params[:form_description]
      form_create_service(uploaded_file, description)
      return head :ok
    rescue => e
      p e.message
      return render json: e.message, status: :bad_request
    end
  end

  def update
    user = get_authenticated_user
    if user.nil?
      return redirect_to sign_in_path
    end
    begin
      form_update_service(params[:form_file], params[:description], params[:selected_seq])
      return head :ok
    rescue => e
      p e.message
      return render json: e.message, status: :bad_request
    end
  end
end