require 'rails_helper'

shared_context 'mock_storage' do
  before do
    storage_spy = spy(Storage)
    allow(Storage).to receive(:new).and_return(storage_spy)
    allow(storage_spy).to receive(:save)
  end
end

shared_context "create_user" do
  let(:_service) { Class.new {include FormService }}
  let(:file) { File.open(Rails.root.join("spec", "fixtures", "files", "sample.xlsx"))}
  let(:service) { _service.new }
  before do
    user = FactoryBot.create(:user)
    allow(service).to receive(:get_authenticated_user).and_return(user)
  end
end

RSpec.feature "FormService", type: :service do
  include_context "mock_storage"
  include_context "create_user"
  describe "create" do
    it "Userに紐づくFormが作成される" do
      # テスト開始時はForm 0 件
      expect(Form.all.size).to eq 0
      uploaded = Rack::Test::UploadedFile.new(file, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
      service.form_create_service(uploaded, "test > form_create_service")
      # Userに紐づくFormが登録されていること
      expect(Form.all.size).to eq 1
    end
  end
  describe "update" do
    context "指定SEQのフォームが存在しない" do
      it "例外がスローされる" do
        uploaded = Rack::Test::UploadedFile.new(file, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
        expect{service.form_update_service(uploaded, "test > form_create_service", 999, true)}.to raise_error(StandardError)
      end
    end
    context "指定SEQのフォームが存在する" do
      let(:new_file) { File.open(Rails.root.join("spec", "fixtures", "files", "size_valid.xlsx")) }
      it "Userに紐づくFormが変更される" do
        # 基準データ作成
        uploaded = Rack::Test::UploadedFile.new(file, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
        service.form_create_service(uploaded, "description_before")
        form_base = Form.find_by(seq: 1)
        # 基準データ変更
        new_file_ = Rack::Test::UploadedFile.new(new_file, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
        service.form_update_service(new_file_, "description_after", 1, "true")
        form_updated = Form.find_by(seq: 1)
        # 各アサーション
        expect(form_base.description).to eq "description_before"
        expect(form_updated.description).to eq "description_after"
        expect(form_base.original_name).to eq "sample.xlsx"
        expect(form_updated.original_name).to eq "size_valid.xlsx"
        # 実際に保存されるファイル名（UUID）は変更されていないこと
        expect(form_updated.file_name).to eq form_base.file_name
      end
    end
  end
  describe "delete" do
    context "指定SEQのフォームが存在しない" do
      it "例外がスローされる" do
        # 基準データ作成
        uploaded = Rack::Test::UploadedFile.new(file, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
        service.form_create_service(uploaded, "description_before")
        expect{service.form_delete_service(999)}.to raise_error(StandardError)
      end
    end
    context "指定SEQのフォームが存在する" do
      it "Userに紐づくFormが削除される" do
        # 基準データ作成
        uploaded = Rack::Test::UploadedFile.new(file, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
        service.form_create_service(uploaded, "description_before")
        expect(Form.all.size).to eq 1
        service.form_delete_service(1)
        expect(Form.all.size).to eq 0
      end
    end
  end
end