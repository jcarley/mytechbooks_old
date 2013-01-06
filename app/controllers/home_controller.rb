class HomeController < ApplicationController
  before_filter :authenticate_user!

  def index
    user_books = Book.where({:user_id => current_user.id}).page(params[:page]).per(5)
    @books = BookDecorator.decorate(user_books)
  end
end
