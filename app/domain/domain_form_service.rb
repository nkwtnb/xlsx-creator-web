module Domain
  module FormService
    def upload_file_to_server(uploaded_file)
      file_name = SecureRandom.uuid + ".xlsx"
      File.open(Rails.root.join('resources', 'xlsx-creator', 'templates', file_name), 'w') do |file|
        file.write(uploaded_file.read.force_encoding("utf-8"))
      end
      return file_name
    end
  end
end