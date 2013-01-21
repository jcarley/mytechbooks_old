require 'spec_helper'

describe SearchController do

  describe "GET 'index'" do
    it "returns http success" do
      get :index
      response.should be_success
    end

    it "should return books" do
      get :index, :criteria => "Paul"
      response.should be_success
    end
  end


end
