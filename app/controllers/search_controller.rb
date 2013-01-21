class SearchController < ApplicationController

  def index
    criteria = params[:criteria]
    book_results = Book.tire_search(criteria)
    @books = BookDecorator.decorate(book_results)
  end

end
