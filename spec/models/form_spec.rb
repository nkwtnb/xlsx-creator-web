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
        puts form.id
      end
    end
  end
end
