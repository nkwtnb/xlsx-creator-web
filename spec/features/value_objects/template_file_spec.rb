require 'rails_helper'

RSpec.feature "ValueObjects::TemplateFiles", type: :feature do
  describe  "添付ファイル" do
    context "拡張子[.xlsx]のみ添付可能" do
      let(:file) { File.open(Rails.root.join("spec", "fixtures", "files", "sample.xlsx"))}
      it '[.xlsx]のファイル' do
        uploaded = Rack::Test::UploadedFile.new(file, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
        ValueObjects::TemplateFile.new(uploaded)
      end
      it '[.xlsx]のファイル以外' do
        uploaded = Rack::Test::UploadedFile.new(file, "image/jpg")
        expect{ValueObjects::TemplateFile.new(uploaded)}.to raise_error(StandardError, "*.xlsxファイルのみ添付可能です。")
      end
    end
    context "サイズ 1024*1024 bytes まで添付可能" do
      let(:valid) { File.open(Rails.root.join("spec", "fixtures", "files", "size_valid.xlsx"))}
      let(:invalid) { File.open(Rails.root.join("spec", "fixtures", "files", "size_invalid.xlsx"))}
      it '指定サイズ以内' do
        uploaded = Rack::Test::UploadedFile.new(valid, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
        expect{ValueObjects::TemplateFile.new(uploaded)}.not_to raise_error
      end
      it '指定サイズ以上' do
        uploaded = Rack::Test::UploadedFile.new(invalid, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
        expect{ValueObjects::TemplateFile.new(uploaded)}.to raise_error(StandardError, "1048576 byteまで添付可能です。")
      end
    end
  end
end
