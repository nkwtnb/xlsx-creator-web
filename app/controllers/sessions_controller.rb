class SessionsController < ApplicationController
  include Auth
  def new
  end

  def create
    token = make_token_if_authenticated(params[:email], params[:password])
    if token == nil
      puts 'ログインできない'
      flash[:danger] = 'メールアドレスかパスワードが間違っています。'
      return redirect_to sign_in_path
    end
    puts 'ログインできた'
    # JWTをCookieにセット
    cookies[:token] = token
    return redirect_to root_path
  end
end
