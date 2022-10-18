class HomeController < ApplicationController
  include Auth
  include FormService
  def new
    user = get_authenticated_user
    if user.nil?
      return redirect_to sign_in_path
    end
    @forms = Form.where(user_id: user.id).order(seq: :asc)
  end
  def download
    # TEMP ファイルパスに応じたファイルの取得確認
    path = Rails.root.join('storage', 'uploads', '1a8f78cc-916e-4d5e-86cf-7a7c613ab6f0.xlsx')
    puts path
    send_file path, filename: 'test.xlsx'
  end
end
