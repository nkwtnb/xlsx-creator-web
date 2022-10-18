class Form < ApplicationRecord
  belongs_to :user
  attribute :file
  def initialize(attribute)
    attribute[:seq] = get_next_sequence(attribute[:user_id])
    super
  end
  def update_attributes(template_file, description)
    self.description = description
    if template_file.present?
      set_file_attributes(template_file)
    end
  end

  private
  def upload_file_to_server(template_file)
    file_name = SecureRandom.uuid + ".xlsx"
    File.open(Rails.root.join('resources', 'xlsx-creator', 'templates', file_name), 'w') do |file|
      file.write(template_file.read)
    end
    return file_name
  end
  def set_file_attributes(template_file)
    file_name = upload_file_to_server(template_file)
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
