require 'rails_helper'

RSpec.describe "Lps", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/lp/new"
      expect(response).to have_http_status(:success)
    end
  end

end
