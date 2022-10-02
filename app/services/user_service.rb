module UserService
  include Auth
  def user_service_create(uploaded_file, description)
    # ユーザー情報取得
    user = get_authenticated_user
    if user.nil?
      raise StandardError.new("認証されていません。")
    end
    # ファイルアップロード
    file_name = SecureRandom.uuid + ".xlsx"
    upload_file_to_server(uploaded_file, file_name)
    # シーケンス採番
    next_seq = get_next_sequence(user.id)
    # DB登録
    form = Form.new(
      user_id: user.id,
      original_name: uploaded_file.original_filename,
      file_name: file_name,
      seq: next_seq,
      description: description
    )
    form.save!
  end

  private

  def get_next_sequence(user_id)
    form = Form
             .where(user_id: user_id)
             .order(seq: :desc)
             .first!
    next_seq = (form.seq.to_i) + 1
    return next_seq
  end

  def upload_file_to_server(uploaded_file, file_name)
    File.open(Rails.root.join('storage', 'uploads', file_name), 'w') do |file|
      file.write(uploaded_file.read.force_encoding("utf-8"))
    end
  end
end
