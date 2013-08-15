class BooksController < ApplicationController
  include CommandBus

  respond_to :json

  before_filter :authenticate_user!

  def index
    # user_books = Book.where({:user_id => current_user.id}).page(params[:page]).per(5)
    # @books = BooksDecorator.decorate(user_books)
    Book.all
  end

  def show
    @book = Book.find(params[:id]).decorate
  end

  def new
  end

  def create
    execute_command(:register_book, current_user.id, params[:book][:isbn])
    result = Book.where(:isbn => params[:book][:isbn]).first
    @book = BookDecorator.decorate(result) if result
  end

  def destroy
    id = params[:id]
    book = Book.find(id)
    unless book.nil?
      book.delete
      @status = "deleted"
      @message = "Successfully deleted book"
    else
      @status = "error"
      @message = "Unable to delete book"
    end
  end
end
