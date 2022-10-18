class SessionsController < ApplicationController
  include Auth
  def new
    token = get_authenticated_user()
    if token.present?
      return redirect_to root_path
    end
  end

  def create
    token = make_token_if_authenticated(params[:email], params[:password])
    if token == nil
      flash[:danger] = 'メールアドレスかパスワードが間違っています。'
      return redirect_to sign_in_path
    end
    # JWTをCookieにセット
    cookies[:token] = token
    return redirect_to root_path
  end

  def delete
    cookies.delete :token
    return redirect_to root_path
  end
end
