require 'spec_helper'

describe HomeController do
  render_views

  before (:each) do
    @user = FactoryGirl.create(:user_with_books)
    sign_in @user
  end

  describe "GET 'index'" do
    it "should be successful" do
      get :index
      expect(response).to be_success
    end

    it "should render index template" do
      get :index
      expect(response).to render_template(:index)
    end

    it "should assign current users books" do
      book = @user.books.first
      get :index
      assigns(:books).should eq([book])
    end


  end

end
