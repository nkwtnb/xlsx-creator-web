class PasswordResetsController < ApplicationController

  def new; end

  def create
    @user = User.find_by_email(params[:email])
    @user&.deliver_reset_password_instructions!
    flash[:success] = "パスワードリセットメールを送信しました"
    redirect_to sign_in_path
  end

  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])
    not_authenticated if @user.blank?
  end

  def update
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      flash[:danger] = ['パスワードを入力してください']
      return redirect_to edit_password_reset_path, id: params[:id]
    end
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])

    return not_authenticated if @user.blank?

    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.change_password(params[:user][:password])
      flash[:success] = "パスワードを変更しました"
      redirect_to sign_in_path
    else
      flash[:danger] = @user.errors.full_messages
      redirect_to edit_password_reset_path, id: params[:id]
    end
  end
end
