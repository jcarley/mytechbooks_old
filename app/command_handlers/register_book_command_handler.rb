class RegisterBookCommandHandler

  attr_reader :user_id, :isbn, :error_message
  attr_accessor :books

  def execute(user_id, isbn)
    @user_id = user_id
    @isbn = isbn
    @books = []

    do_work

    unless success?
      @error_message = 'Error: Unable to register book'
    end

    self
  end

  def success?
    books.empty? ? false : true
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
          user.register_book(book)
        end
        user.save
      end
    end

    def find_user
      User.find(user_id)
    end

end
