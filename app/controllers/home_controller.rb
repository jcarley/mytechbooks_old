class HomeController < ApplicationController
  before_filter :authenticate_user!

  def index
    @books = BookDecorator.decorate(current_user.books)
  end
end
