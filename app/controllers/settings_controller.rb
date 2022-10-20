class SettingsController < ApplicationController
  include Auth
  def new
    @authenticated_user = get_authenticated_user
  end
  def update
    authenticated_user = get_authenticated_user
    begin
      user = User.find_by(email: authenticated_user.email)
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
    puts "Hello, delete"
  end
end
