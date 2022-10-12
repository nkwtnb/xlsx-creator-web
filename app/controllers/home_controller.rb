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
  def create
    begin
      uploaded_file = params[:form_file]
      description = params[:form_description]
      form_create_service(uploaded_file, description)

      return redirect_to action: :new, status: :created
    rescue => e
      p e.message
      return render json: e.message, status: :bad_request
    end
  end

  def get_form_info
    user = get_authenticated_user
    if user.nil?
      return redirect_to sign_in_path
    end
    @registered_form = Form.where(user_id: user.id, seq: params[:seq]).first
    render json: {
      value: {
        description: @registered_form.description,
        originalName: @registered_form.original_name,
      }
    }
  end
  def put
    user = get_authenticated_user
    if user.nil?
      return redirect_to sign_in_path
    end
    begin
      form_update_service(params[:form_file], params[:description], params[:selected_seq])
      return render action: :new, status: :ok
    rescue => e
      p e.message
      return render json: e.message, status: :bad_request
    end
  end

  def download
    # TEMP ファイルパスに応じたファイルの取得確認
    path = Rails.root.join('storage', 'uploads', '1a8f78cc-916e-4d5e-86cf-7a7c613ab6f0.xlsx')
    puts path
    send_file path, filename: 'test.xlsx'
  end
end
