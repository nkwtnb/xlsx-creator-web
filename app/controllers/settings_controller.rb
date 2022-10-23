class SettingsController < ApplicationController
  include Auth
  def new
    puts "new"
    @authenticated_user = get_authenticated_user
    if @authenticated_user.nil?
      return redirect_to sign_in_path
    end
  end
  def update
    @authenticated_user = get_authenticated_user
    begin
      user = User.find_by(email: @authenticated_user.email)
      user.email = params[:email]
      user.save!
    rescue => e
      flash[:danger] = e.message
      return render :new, status: :unprocessable_entity
    end
    flash[:success] = "メールアドレスを変更しました"
    return redirect_to settings_path
  end
  def delete
    begin
      user = get_authenticated_user
      user.destroy!
      cookies.delete :token
      # TODO 登録した帳票テンプレートの削除
      flash[:success] = "アカウントを削除しました"
      return redirect_to sign_up_path
    rescue ActiveRecord::RecordInvalid => e
      flash[:danger] = e.message
      return redirect_to settings_path
    rescue => e
      flash[:danger] = "アカウントの削除時にエラーが発生しました"
      return redirect_to settings_path
    end
  end
end
