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
    command = execute_command(:register_book, current_user.id, params[:book][:isbn])

    @result = Hashie::Mash.new
    @result.book = BookDecorator.decorate(command.books.first) if command.success?
    @result.error_message = command.error_message unless command.success?
    @result.success = command.success?

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
