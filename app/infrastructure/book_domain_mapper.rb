class BookDomainMapper
  def self.to_book(item)
    book = Book.new
    book.title = item.title
    book.author = item.raw.ItemAttributes.Author
    book.ean = item.raw.ItemAttributes!.EAN
    book.isbn = item.raw.ItemAttributes!.ISBN
    book.pages = item.raw.ItemAttributes!.NumberOfPages.to_i
    book.binding = item.raw.ItemAttributes!.Binding
    book.edition = item.raw.ItemAttributes!.Edition.to_i
    book.formatted_price = item.raw.ItemAttributes!.ListPrice!.FormattedPrice
    book.asin = item.asin
    book.amount = item.amount
    book.details_url = item.details_url
    book.description = item.raw.EditorialReviews!.EditorialReview!.Content
    book.small_img_url = item.raw.SmallImage!.URL
    book.medium_img_url = item.raw.MediumImage!.URL
    book.large_img_url = item.image_url
    book.publisher = item.raw.ItemAttributes!.Publisher
    book.published_on = item.raw.ItemAttributes!.PublicationDate
    book
  end
end

# <EditorialReviews>
  # <EditorialReview>
    # <Source>Product Description</Source>
    # <Content>&lt;b&gt; The Complete Guide to Building Highly
