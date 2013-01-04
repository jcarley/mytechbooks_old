class BooksController < ApplicationController
  include CommandBus

  respond_to :js, :only => [:create, :destroy]

  before_filter :authenticate_user!

  def show
  end

  def create
    execute_command(:register_book, current_user.id, params[:book][:isbn]) do |result|
      @result = Hashie::Mash.new(result)
      @result.book = BookDecorator.decorate(result[:book].first) if result[:success]
    end
    respond_with :js
  end

  def destroy
    @id = params[:id]
    book = Book.where(:id => @id)
    unless book.nil?
      book.delete
    end
    respond_with :js
  end
end
