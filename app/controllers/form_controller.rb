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
      return render json: {
        message: e.message
      }, status: :bad_request
    end
  end

  def delete
    begin
      form_delete_service(params[:selected_seq])
      return head :ok
    rescue => e
      return render json: {
        message: e.message
      }, status: :bad_request
    end
  end
end

