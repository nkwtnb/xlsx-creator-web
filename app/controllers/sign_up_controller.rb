class SignUpController < ApplicationController
  include Auth
  include SignInService
  def new
    user = get_authenticated_user
    if user.present?
      redirect_to sign_in_path
    end
  end

  def create
    begin
      @user = User.new(
        email: params[:email],
        password: params[:password],
        password_confirmation: params[:password_confirmation],
        )
      @user.save!
      sign_in(params[:email], params[:password])
    rescue ActiveRecord::RecordInvalid
      flash.now[:danger] = @user.errors.full_messages
      render :new, status: :unprocessable_entity
    rescue => e
      flash.now[:danger] = [e.message]
      render :new, status: :unprocessable_entity
    end
  end
end
