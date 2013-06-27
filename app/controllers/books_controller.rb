class BooksController < ApplicationController
  include CommandBus

  respond_to :js, :only => [:create, :destroy]

  before_filter :authenticate_user!

  def show
    @book = BookDecorator.find(params[:id])
  end

  def new
  end

  def create
    execute_command(:register_book, current_user.id, params[:book][:isbn])
    result = Book.where(:isbn => params[:book][:isbn]).first
    @book = BookDecorator.decorate(result)

    respond_with :js
  end

  def destroy
    @id = params[:id]
    book = Book.where(:id => @id)
    unless book.nil?
      book.destroy
    end
    respond_with :js
  end
end
