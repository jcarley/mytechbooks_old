class RegisterBookCommandHandler

  attr_reader :user_id, :isbn
  attr_accessor :books

  def execute(user_id, isbn)
    @user_id = user_id
    @isbn = isbn
    @books = []

    do_work

    if block_given?
      result = {success: success?, book: books}
      unless success?
        result[:error] = 'Error: Unable to register book'
      end
      yield result
    else
      return success?
    end

  end

  private
    def do_work
      search_for_books
      add_books_to_user
    end

    def search_for_books
      api = AmazonSimpleSearch.new
      api.search(isbn) do |item|
        book = BookDomainMapper.to_book(item)
        books << book
      end
    end

    def add_books_to_user
      unless books.empty?
        user = find_user
        books.each do |book|
          user.books << book
        end
        user.save
      end
    end

    def find_user
      User.find(user_id)
    end

    def success?
      books.empty? ? false : true
    end

end
