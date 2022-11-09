require 'rails_helper'

RSpec.describe "Forms", type: :request do
  before do
    mock_storage
  end
  include Utilities
  describe "POST /form/create" do
    let!(:user) { FactoryBot.create(:user)}
    context "未認証" do
      it "認証エラーになり、Form追加できない" do
        file = upload_file("size_valid.xlsx")
        post create_path, params: {
          form_file: file
        }
        expect(response.status).to eq 400
      end
    end
    context "認証済み" do
      it "Form追加できる" do
        login
        file = upload_file("size_valid.xlsx")
        post create_path, params: {
          form_file: file,
        }
        expect(response.status).to eq 200
      end
    end
  end
  describe "POST /form/update" do
    let!(:user) { FactoryBot.create(:user)}
    context "未認証" do
      it "認証エラーになり、Form更新できない" do
        file = upload_file("size_valid.xlsx")
        post update_path, params: {
          form_file: file
        }
        expect(response.status).to eq 400
      end
    end
    context "認証済み" do
      context "存在するファイルID" do
        it "Form更新できる" do
          login
          file = upload_file("size_valid.xlsx")
          post create_path, params: {
            form_file: file,
          }
          post update_path, params: {
            form_file: file,
            selected_seq: 1
          }
          expect(response.status).to eq 200
        end
      end
      context "存在しないファイルID" do
        it "エラーになり、Form更新できない" do
          login
          file = upload_file("size_valid.xlsx")
          post create_path, params: {
            form_file: file,
          }
          post update_path, params: {
            form_file: file,
            selected_seq: 2
          }
          expect(response.status).to eq 400
        end
      end
    end
  end
  describe "DELETE /form/delete" do
    let!(:user) { FactoryBot.create(:user)}
    context "未認証" do
      it "フォーム削除" do
        delete delete_path
        expect(response.status).to eq 400
        resp = JSON.parse(response.body)
        expect(resp["message"]).to eq "認証されていません"
      end
    end
    context "認証済み" do
      context "存在しないファイルID" do
        it "フォーム削除" do
          login
          file = upload_file("size_valid.xlsx")
          post create_path, params: {
            form_file: file,
          }
          delete delete_path, params: {
            selected_seq: 1
          }
          expect(response.status).to eq 200
        end
      end
      context "存在するファイルID" do
        it "フォーム削除" do
          login
          file = upload_file("size_valid.xlsx")
          post create_path, params: {
            form_file: file,
          }
          delete delete_path, params: {
            selected_seq: 2
          }
          expect(response.status).to eq 400
        end
      end
    end
  end
end
