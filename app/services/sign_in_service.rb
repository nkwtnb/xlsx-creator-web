module SignInService
  include Auth
  def sign_in(email, password)
    token = make_token_if_authenticated(email, password)
    if token == nil
      flash.now[:danger] = 'メールアドレスかパスワードが間違っています。'
      return render :new, status: :unprocessable_entity
    end
    # JWTをCookieにセット
    # ローカルではsecure: falseでテストしたい為、Cloud Runにデプロイする際に環境変数でtrueとする
    cookies[:token] = {value: token, httponly: true, secure: ENV.fetch("RAILS_IS_DEPLOYED") == "true"}
    return redirect_to root_path
  end
end