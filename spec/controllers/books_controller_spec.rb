require 'spec_helper'

describe BooksController, :vcr do
  render_views

  before(:each) do
    @user = FactoryGirl.create(:user_with_books)
    sign_in @user
  end

  describe "GET 'show'" do
    it "returns http success" do
      get :show, :id => @user.books.first
      response.should be_success
    end
  end

  describe "POST 'create'" do

    context "success" do

      let(:params) do
        {:isbn => '0321659368'}
      end

      it "should create a book" do
        expect { post :create, :book => params }.to change{Book.all.count}.by(1)
      end

      it "should assign result" do
        post :create, :book => params
        assigns(:result).should be_true
      end

      it "should have a successful result" do
        post :create, :book => params
        assigns(:result)["success"].should be_true
      end
    end

    context "failure" do

      let(:params) do
        {:isbn => '0321119368'}
      end

      it "should not create a book" do
        expect { post :create, :book => params }.to_not change{Book.all.count}.by(1)
      end

      it "should assign result" do
        post :create, :book => params
        assigns(:result).should be_true
      end

      it "should not have a successful result" do
        post :create, :book => params
        assigns(:result)["success"].should be_false
      end

      it "should have a error message" do
        post :create, :book => params
        assigns(:result)["error"].should_not be_empty
      end

    end

  end

  describe "POST 'delete'" do

    it "should remove a book" do
      expect { post :destroy, :id => @user.books.first.id }.to change{Book.all.count}.by(-1)
    end

    it "should assign book id" do
      post :destroy, :id => @user.books.first.id
      assigns(:id).should be_true
    end
  end

end
