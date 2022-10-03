class HomeController < ApplicationController
  include Auth
  include UserService
  def new
    user = get_authenticated_user()
    if user.nil?
      return redirect_to sign_in_path
    end
    @forms = Form.where(user_id: user.id).order(seq: :asc)
  end
  def create
    begin
      uploaded_file = params[:form_file]
      description = params[:form_description]
      user_service_create(uploaded_file, description)

      return redirect_to action: :new, status: :created
    rescue => e
      p e.message
      return render json: e.message, status: :bad_request
    end
  end

  def put
    # user = get_authenticated_user()
    # if user.nil?
    #   return redirect_to sign_in_path
    # end
    # puts "This is put"
    # @forms = Form.where(user_id: user.id).order(seq: :asc)
    # puts @forms
    # @update_form = Form.where(user_id: user.id, seq: 1).first
    # puts @update_form
    # render action: :new
  end

  def delete
    user = get_authenticated_user()
    if user.nil?
      return redirect_to sign_in_path
    end
    form = Form.where(user_id: user.id, seq: params[:seq]).first
    if form.nil?
      # TODO 動作確認
      return render json: {message: "存在しない"}, status: :bad_request
    end
    form.destroy
    return redirect_to action: :new
  end

  def download
    # TEMP ファイルパスに応じたファイルの取得確認
    path = Rails.root.join('storage', 'uploads', '1a8f78cc-916e-4d5e-86cf-7a7c613ab6f0.xlsx')
    puts path
    send_file path, filename: 'test.xlsx'
  end
end
