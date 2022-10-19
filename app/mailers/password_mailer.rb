class PasswordMailer < ApplicationMailer
  default from: 'XLSX Creator'

  def reset_password_email(user)
    @user = User.find(user.id)
    @url = edit_password_reset_url(@user.reset_password_token)
    mail(to: @user.email, subject: "Your password has been reset")
    # @user = {
    #   email: "n.watanabe0305@gmail.com",
    #   name: "Naoki",
    # }
    # @url = "http://localhost:3000"
    # mail(to: @user[:email], subject: '私の素敵なサイトへようこそ')
  end
end
