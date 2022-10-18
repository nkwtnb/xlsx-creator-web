module ValueObjects
  class TemplateFile
    FILE_SIZE_LIMIT = 1024 * 1024
    MIME_TYPE = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    def initialize(file)
      if file.nil?
        raise StandardError.new("添付ファイルは必須です。")
      end
      @file = file
      validate
    end

    def get_name
      @file.original_filename
    end

    def read
      @file.read.force_encoding("utf-8")
    end

    def validate
      if @file.size > FILE_SIZE_LIMIT
        raise StandardError.new("#{FILE_SIZE_LIMIT} byteまで添付可能です。")
      end
      if @file.content_type != MIME_TYPE
        raise StandardError.new("*.xlsxファイルのみ添付可能です。")
      end
    end
  end
end

