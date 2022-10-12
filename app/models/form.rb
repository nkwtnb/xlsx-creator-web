class Form < ApplicationRecord
  include DomainFormService
  belongs_to :user
  def update(uploaded_file, description, seq)
    self.description = description
    if uploaded_file.present?
      file_name = upload_file_to_server(uploaded_file)
      self.original_name = uploaded_file.original_filename
      self.file_name = file_name
    end
  end
end
