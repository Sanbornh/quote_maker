require 'spec_helper'

describe OauthsController do

  describe "GET 'oauth'" do
    it "returns http success" do
      get 'oauth'
      expect(response).to be_success
    end
  end

  describe "GET 'callback'" do
    it "returns http success" do
      get 'callback'
      expect(response).to be_success
    end
  end

end
