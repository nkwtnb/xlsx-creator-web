require 'rails_helper'

RSpec.describe "Settings", type: :request do
  describe "POST /settings" do
    context "未認証" do
      it 'エラーになること' do
        post settings_path, params: {
          email: nil
        }
      end
    end
    context "認証済み" do
      let!(:base_user) {FactoryBot.create(:user) }
      let!(:exists_user) {FactoryBot.create(:user, email: "exists@example.com") }
      context "メールアドレス未入力" do
        it "エラーになること" do
          expect(base_user.email).to eq "test@example.com"
          post sign_in_path, params: {
            email: "test@example.com",
            password: "password"
          }
          # メールアドレスを空白に設定
          post settings_path, params: {
            email: ""
          }
          expect(response).to have_http_status(422)
          expect(flash[:danger]).to eq ["メールアドレスは必須です"]
        end
      end
      context "存在するメールアドレス" do
        it "エラーになること" do
          expect(base_user.email).to eq "test@example.com"
          post sign_in_path, params: {
            email: "test@example.com",
            password: "password"
          }
          # 存在するメールアドレスに変更
          post settings_path, params: {
            email: "exists@example.com"
          }
          expect(response).to have_http_status(422)
          expect(flash[:danger]).to eq ["メールアドレスはすでに存在します"]
        end
      end
      context "存在しないメールアドレス" do
        it "メールアドレスが変更できること" do
          expect(base_user.email).to eq "test@example.com"
          post sign_in_path, params: {
            email: "test@example.com",
            password: "password"
          }
          post settings_path, params: {
            email: "new_email@example.com"
          }
          updated = User.find_by(id: base_user.id)
          expect(updated.email).to eq "new_email@example.com"
          expect(response).to have_http_status(302)
          expect(flash[:success]).to eq "メールアドレスを変更しました"
          expect(response).to redirect_to settings_path
        end
      end
    end
  end
end
