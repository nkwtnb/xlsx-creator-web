require "google/cloud/storage"

class Storage
  def initialize
    @storage = Google::Cloud::Storage.new(
      project_id: ENV["RAILS_GCS_PROJECT"],
      credentials: JSON.parse(Base64.decode64(ENV["RAILS_GCS_CREDENTIALS"]))
    )
    @bucket = @storage.bucket(ENV["RAILS_GCS_BUCKET"])
  end
  def get(file_name)
    @bucket.file(file_name)
  end
  def save(contents, file_name)
    begin
      @bucket.create_file(StringIO.new(contents), file_name)
    rescue => e
      puts e.message
      raise StandardError.new("ファイルの作成に失敗しました")
    end
  end
  def delete(file_name)
    file = get(file_name)
    if file.nil?
      raise StandardError.new("対象のファイルが存在しません")
    end
    if file.delete == false
      raise StandardError.new("対象のファイルの削除に失敗しました")
    end
  end
end
