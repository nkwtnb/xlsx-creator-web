class Form < ApplicationRecord
  belongs_to :user
  attribute :file
  def initialize(attribute)
    attribute[:seq] = get_next_sequence(attribute[:user_id])
    super
  end
  def update_attributes(template_file, description, old_file_name = nil)
    self.description = description
    if template_file.present?
      file_name = upload_file_to_server(template_file, old_file_name)
      set_file_attributes(template_file, file_name)
    end
  end

  private
  def upload_file_to_server(template_file, old_file_name = nil)
    file_name = SecureRandom.uuid + ".xlsx"
    if old_file_name.present?
      file_name = old_file_name
    end
    storage = Storage.new
    storage.save(template_file.read, file_name)
    return file_name
  end
  def set_file_attributes(template_file, file_name)
    self.original_name = template_file.get_name
    self.file_name = file_name
  end
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
