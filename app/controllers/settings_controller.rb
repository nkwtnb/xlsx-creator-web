class SettingsController < ApplicationController
  include Auth
  def new
    @authenticated_user = get_authenticated_user
    if @authenticated_user.nil?
      return redirect_to sign_in_path
    end
  end
  def update
    @authenticated_user = get_authenticated_user
    begin
      if @authenticated_user.nil?
        raise StandardError.new("認証されていません")
      end
      user = User.find_by(email: @authenticated_user.email)
      user.email = params[:email]
      user.save!
    rescue ActiveRecord::RecordInvalid
      flash[:danger] = user.errors.full_messages
      return render :new, status: :unprocessable_entity
    rescue => e
      flash[:danger] = [e.message]
      return render :new, status: :unprocessable_entity
    end
    flash[:success] = "メールアドレスを変更しました"
    return redirect_to settings_path
  end
  def delete
    begin
      user = get_authenticated_user
      user.destroy!
      storage = Storage.new
      forms = Form.where(user_id: user.id)
      forms.each do |f|
        storage.delete(f.file_name)
      end
      cookies.delete :token
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
