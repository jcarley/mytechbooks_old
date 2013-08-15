require 'spec_helper'

describe BooksController, :vcr do
  render_views

  before(:each) do
    @user = FactoryGirl.create(:user_with_books)
    sign_in @user
  end

  describe "GET 'show'" do
    it "returns http success" do
      get :show, :id => @user.books.first, :format => :json
      response.should be_success
    end
  end

  describe "POST 'create'" do

    context "with a valid isbn" do

      let(:params) do
        {:isbn => '0321659368'}
      end

      it "should create a book" do
        expect { post :create, :book => params, :format => :json }.to change(Book, :count).by(1)
      end

      it "should have a successful result" do
        post :create, :book => params, :format => :json
        expect(assigns(:book)).to_not be_nil
      end
    end

    context "with an invalid isbn" do

      let(:params) do
        {:isbn => '0321119368'}
      end

      it "should not create a book" do
        expect { post :create, :book => params, :format => :json }.to_not change(Book, :count).by(1)
      end

      it "should not have a successful result" do
        post :create, :book => params, :format => :json
        expect(assigns(:book)).to be_nil
      end

      it "should have an error message" do
        post :create, :book => params, :format => :json
        expect(response.body).to match /Unable to register book with isbn equal to/
      end

    end

  end

  describe "POST 'delete'" do

    context "when given an existing book id" do
      it "should remove a book" do
        expect { post :destroy, :id => @user.books.first.id, :format => :json }.to change(Book, :count).by(-1)
      end

      it "should have a success status message" do
        post :destroy, :id => @user.books.first.id, :format => :json
        expect(response.body).to match /Successfully deleted book/
      end
    end

    context "when given a non-existing book id" do
      it "should not remove a book" do
        expect { post :destroy, :id => 99999, :format => :json }.to change(Book, :count).by(0)
      end

      it "should have an error status message" do
        post :destroy, :id => 9999, :format => :json
        expect(response.body).to match /Unable to delete book/
      end
    end
  end

  describe "POST 'show'" do

    let(:book) do
      BookDecorator.decorate(FactoryGirl.create(:book_with_user))
    end

    it "should be successful" do
      post :show, :id => book, :format => :json
      expect(response).to be_success
    end

    it "should assign book" do
      post :show, :id => book, :format => :json
      expect(assigns(:book)).to_not be_nil
    end

    it "should display the book title" do
      post :show, :id => book, :format => :json
      expect(response.body).to have_content(book.title)
    end

    it "should display the book sub title" do
      post :show, :id => book, :format => :json
      expect(response.body).to have_content(book.sub_title)
    end

    it "should display the book cover image" do
      post :show, :id => book, :format => :json
      expect(response.body).to have_content(book.medium_img_url)
    end

    it "should display the book MSRP" do
      post :show, :id => book, :format => :json
      expect(response.body).to have_content(book.formatted_price)
    end

    it "should display the book binding" do
      post :show, :id => book, :format => :json
      expect(response.body).to have_content(book.binding)
    end

    it "should display the book number of pages" do
      post :show, :id => book, :format => :json
      expect(response.body).to have_content(book.pages)
    end
  end

end
