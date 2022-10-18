module FormService
  include Auth
  include DomainFormService
  def form_create_service(uploaded_file, description)
    # ユーザー情報取得
    user = get_authenticated_user
    if user.nil?
      raise StandardError.new("認証されていません。")
    end
    is_form_too_many(user.id)
    template_file = ValueObjects::TemplateFile.new(uploaded_file)
    # DB登録
    form = Form.new(
      user_id: user.id,
    )
    form.update_attributes(template_file, description)
    form.save!
  end

  def form_update_service(uploaded_file, description, seq, is_update_form)
    # ユーザー情報取得
    user = get_authenticated_user
    if user.nil?
      raise StandardError.new("認証されていません。")
    end
    if is_update_form == "true"
      template_file = ValueObjects::TemplateFile.new(uploaded_file)
    end
    # DB登録
    form = Form.where(user_id: user.id, seq: seq).first
    form.update_attributes(template_file, description)
    form.save!
  end
end
