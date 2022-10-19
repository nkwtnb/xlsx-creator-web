class MailController < ApplicationController
  def new
  end

  def create
    puts "hello, mail create"
    puts "メール送信"
    puts params[:email]
    PasswordMailer.welcome_email(params[:email]).deliver_now
    puts "メール送信"
  end
end
