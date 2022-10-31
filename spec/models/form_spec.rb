require 'rails_helper'

RSpec.describe 'Formモデル', type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe "必須入力チェック" do
    context "未入力時" do
      it "エラーになる" do
        user = FactoryBot.create(:user)
        form = Form.new(user_id: user.id)
        form.valid?
        form.save
        expect(form.errors[:original_name]).to be_present
        expect(form.errors[:file_name]).to be_present
      end
    end
    context "入力時" do
      it "エラーにならずに保存できる" do
        user = FactoryBot.create(:user)
        form = Form.new(user_id: user.id)
        form.original_name = "original_name"
        form.file_name = "file_name"
        form.valid?
        form.save
        expect(form.errors.size).to eq 0
      end
    end
  end

  describe "SEQの取得" do
    it "Userに紐づいたFormのSEQが取得できる" do
      user1= FactoryBot.create(:user)
      form1 = Form.new(user_id: user1.id)
      form1.original_name = "original_name"
      form1.file_name = "file_name"
      form1.save
      form2 = Form.new(user_id: user1.id)
      # user1に紐づくform1,2のSEQ
      expect(form1.seq).to eq 1
      expect(form2.seq).to eq 2

      user2 = FactoryBot.create(:user, email: "test2@example.com")
      form3 = Form.new(user_id: user2.id)
      form3.original_name = "original_name"
      form3.file_name = "file_name"
      form3.save
      # user2に紐づくform3のSEQ
      expect(form3.seq).to eq 1
    end
  end

  describe "ファイルアップロード" do
    let(:file) { File.open(Rails.root.join("spec", "fixtures", "files", "size_valid.xlsx"))}
    let(:uploaded) { Rack::Test::UploadedFile.new(file, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet") }
    let(:template_file) { ValueObjects::TemplateFile.new(uploaded) }
    context "ファイル添付あり" do
      it "アップロード処理される（ファイル名が設定される）" do
        storage_spy = spy(Storage)
        allow(Storage).to receive(:new).and_return(storage_spy)
        allow(storage_spy).to receive(:save)
        user = FactoryBot.create(:user)
        form = Form.new(user_id: user.id)
        form.update_attributes(template_file, "")
        expect(form.original_name).to be_present
        expect(form.file_name).to be_present
      end
    end
    context "ファイル添付なし" do
      it "アップロード処理されない（ファイル名が設定されない）" do
        storage_spy = spy(Storage)
        allow(Storage).to receive(:new).and_return(storage_spy)
        allow(storage_spy).to receive(:save)
        user = FactoryBot.create(:user)
        form = Form.new(user_id: user.id)
        form.update_attributes(nil, "")
        expect(form.original_name).not_to be_present
        expect(form.file_name).not_to be_present
      end
    end
  end
end
