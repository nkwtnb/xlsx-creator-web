module DomainFormService
  FILE_COUNT_LIMIT = 2
  def is_form_too_many(user_id)
    form = Form.where(user_id: user_id)
    if form.size >= FILE_COUNT_LIMIT
      raise StandardError.new("ファイルは #{FILE_COUNT_LIMIT} 件まで登録可能です。")
    end
  end
end
