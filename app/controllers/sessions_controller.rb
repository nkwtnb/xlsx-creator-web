class SessionsController < ApplicationController
  include Auth
  include SignInService
  def new
    token = get_authenticated_user()
    if token.present?
      return redirect_to root_path
    end
  end

  def create
    sign_in(params[:email], params[:password])
  end

  def delete
    cookies.delete :token
    return redirect_to root_path
  end
end
