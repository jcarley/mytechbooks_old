require 'spec_helper'

describe BooksController, :vcr do
  render_views

  before(:each) do
    @user = FactoryGirl.create(:user_with_books)
    sign_in @user
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show'
      response.should be_success
    end
  end

  context "POST 'create'" do

    let(:params) do
      {:isbn => '0321659368'}
    end

    it "should create a book" do
      expect { post :create, :book => params }.to change{Book.all.count}.by(1)
    end

  end

end
