module FormService
  include Auth
  include DomainFormService
  def form_create_service(uploaded_file, description)
    # ユーザー情報取得
    user = get_authenticated_user
    if user.nil?
      raise StandardError.new("認証されていません。")
    end
    if uploaded_file.nil?
      raise StandardError.new("アップロードするファイルを選択してください。")
    end
    puts description
    # ファイルアップロード
    file_name = upload_file_to_server(uploaded_file)
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

  def form_update_service(uploaded_file, description, seq)
    # ユーザー情報取得
    user = get_authenticated_user
    if user.nil?
      raise StandardError.new("認証されていません。")
    end
    # ファイルアップロード
    #TODO ファイル更新チェックのバリデート
    form = Form.where(user_id: user.id, seq: seq).first
    form.update(uploaded_file, description, seq)
    form.save!
  end

  private

  def get_next_sequence(user_id)
    form = Form
             .where(user_id: user_id)
             .order(seq: :desc)
             .first
    if form.nil?
      return 1
    end
    next_seq = (form.seq.to_i) + 1
    return next_seq
  end
end
