module SignInService
  include Auth
  def sign_in(email, password)
    puts "Hello, sign in"
    token = make_token_if_authenticated(email, password)
    if token == nil
      flash.now[:danger] = 'メールアドレスかパスワードが間違っています。'
      return render :new, status: :unprocessable_entity
    end
    # JWTをCookieにセット
    cookies[:token] = token
    return redirect_to root_path
  end
end