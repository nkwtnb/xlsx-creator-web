module Utilities
  def login
    post "/sign_in", params: {
      email: "test@example.com",
      password: "password"
    }
    if response.status == 422
      puts flash.to_hash
      puts response.message
      raise StandardError.new("ログインエラー")
    end
  end
  def create_form
    file = upload_file("size_valid.xlsx")
    post create_path, params: {
      form_file: file
    }
  end
  def upload_file(file_path)
    file = File.open(Rails.root.join("spec", "fixtures", "files", file_path))
    uploaded = Rack::Test::UploadedFile.new(file, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
  end
  def mock_storage
    storage_spy = spy(Storage)
    allow(Storage).to receive(:new).and_return(storage_spy)
    allow(storage_spy).to receive(:save)
  end
end