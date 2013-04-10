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

    context "with a valid isbn" do

      let(:params) do
        {:isbn => '0321659368'}
      end

      it "should create a book" do
        expect { post :create, :book => params }.to change(Book, :count).by(1)
      end

      it "should have a successful result" do
        post :create, :book => params
        expect(assigns(:result)[:success]).to be_true
      end
    end

    context "with an invalid isbn" do

      let(:params) do
        {:isbn => '0321119368'}
      end

      it "should not create a book" do
        expect { post :create, :book => params }.to_not change(Book, :count).by(1)
      end

      it "should not have a successful result" do
        post :create, :book => params
        expect(assigns(:result)[:success]).to be_false
      end

      it "should have a error message" do
        post :create, :book => params
        expect(assigns(:result)[:error_message]).to_not be_nil
      end

    end

  end

  describe "POST 'delete'" do

    it "should remove a book" do
      expect { post :destroy, :id => @user.books.first.id }.to change(Book, :count).by(-1)
    end

    it "should assign book id" do
      post :destroy, :id => @user.books.first.id
      expect(assigns(:id)).to_not be_nil
    end
  end

  describe "POST 'show'" do

    let(:book) do
      BookDecorator.decorate(FactoryGirl.create(:book_with_user))
    end

    it "should be successful" do
      post :show, :id => book
      expect(response).to be_success
    end

    it "should assign book" do
      post :show, :id => book
      expect(assigns(:book)).to_not be_nil
    end

    it "should display the book title" do
      post :show, :id => book
      expect(response.body).to have_content(book.title)
    end

    it "should display the book sub title" do
      post :show, :id => book
      expect(response.body).to have_content(book.sub_title)
    end

    it "should display the book cover image" do
      post :show, :id => book
      expect(response.body).to have_xpath("//img[@src='#{book.medium_img_url}']")
    end

    it "should display the book MSRP" do
      post :show, :id => book
      expect(response.body).to have_content(book.formatted_price)
    end

    it "should display the book number of pages" do
      post :show, :id => book
      expect(response.body).to have_content("#{book.binding}: #{book.pages}")
    end
  end

end
