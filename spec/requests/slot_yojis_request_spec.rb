require 'rails_helper'

RSpec.describe "SlotYojis", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/slot_yojis/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/slot_yojis/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/slot_yojis/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
