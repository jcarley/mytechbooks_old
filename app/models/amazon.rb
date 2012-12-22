require 'asin'

class Amazon
  include ASIN::Client

  def search(criteria)
    begin
      items = search_keywords criteria, {:SearchIndex => :Books, :ResponseGroup => :Medium}
      books = to_books(items)
      if block_given?
        unless books.nil?
          books.each do |book|
            yield book
          end
        end
      else
        return books
      end
    rescue Exception => e
      Rails.logger.info e
    end
  end

  private

    def to_books(items)
      return nil if items.nil?

      books = []

      items.each do |item|
        book = Book.new
        book.title = item.title
        book.ean = item.raw.ItemAttributes!.EAN
        book.isbn = item.raw.ItemAttributes!.ISBN
        book.pages = item.raw.ItemAttributes!.NumberOfPages.to_i
        book.binding = item.raw.ItemAttributes!.Binding
        book.edition = item.raw.ItemAttributes!.Edition.to_i
        book.formatted_price = item.raw.ItemAttributes!.ListPrice!.FormattedPrice
        book.asin = item.asin
        book.amount = item.amount
        book.details_url = item.details_url
        book.small_img_url = item.raw.SmallImage!.URL
        book.medium_img_url = item.raw.MediumImage!.URL
        book.large_img_url = item.image_url
        book.publisher = item.raw.ItemAttributes!.Publisher
        book.published_on = item.raw.ItemAttributes!.PublicationDate
        books << book
      end
      books
    end

end
