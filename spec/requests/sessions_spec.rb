require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "POST /sign_in" do
    let!(:user) {FactoryBot.create(:user) }
    let(:dummy) { Class.new(ApplicationController) { include Auth }}
    context "正しいemail, password" do
      it 'ログインできる' do
        service = dummy.new
        # テスト環境のcookiesを使用するようにモック
        allow(service).to receive(:cookies).and_return(cookies)
        user = service.get_authenticated_user
        expect(user).to be_nil
        post sign_in_path, params: {
          email: "test@example.com",
          password: "password"
        }
        user = service.get_authenticated_user
        expect(user.email).to eq "test@example.com"
        expect(@response.cookies["token"]).to be_present
        expect(response).to redirect_to root_path
      end
    end
    context "誤ったemail" do
      it "エラーになる" do
        post sign_in_path, params: {
          email: "wrong@example.com",
          password: "password"
        }
        expect(@response.cookies["token"]).to be_nil
        expect(response).to have_http_status(422)
      end
    end
    context "誤ったpassword" do
      it "エラーになる" do
        post sign_in_path, params: {
          email: "test@example.com",
          password: "wrong_password"
        }
        expect(@response.cookies["token"]).to be_nil
        expect(response).to have_http_status(422)
      end
    end
  end
  describe "POST /sign_out" do
    let!(:user) {FactoryBot.create(:user) }
    context "ログイン済み" do
      it 'cookies[token]がクリアされる' do
        post sign_in_path, params: {
          email: "test@example.com",
          password: "password"
        }
        expect(@response.cookies["token"]).to be_present
        post sign_out_path
        expect(@response.cookies["token"]).to be_nil
      end
    end
    context "未ログイン" do
      it 'エラー' do
        post sign_out_path
      end
    end
  end
end
