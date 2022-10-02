class HomeController < ApplicationController
  include Auth
  include UserService
  def new
    # create_user_service
    token = get_authenticated_user()
    if token.nil?
      return redirect_to sign_in_path
    end
  end
  def create
    begin
      uploaded_file = params[:form_file]
      description = params[:form_description]
      user_service_create(uploaded_file, description)

      return render status: :created
    rescue => e
      p e.message
      return render json: e.message, status: :bad_request
    end
  end
end
