class BookDecorator < Draper::Base
  decorates :book

  # .two.columns
    # img src="http://placehold.it/1000x1000&text=Thumbnail"
  # .ten.columns
    # h5 Item Name
    # h6.subheader Freddy George (Dec 2011)
    # dl
      # dd MSRP: $100.00
      # dd Pages: 345
  # hr
  def result
    book_title = h.content_tag(:h5, book.title)
    author = h.content_tag(:h6, "#{book.author} (#{book.published_on.strftime("%b %Y")})", {:class => "subheader"})

    book_price = h.content_tag(:dd, "MSRP: #{book.formatted_price}")
    book_page_count = h.content_tag(:dd, "Pages: #{book.pages}")
    data_list = h.content_tag(:dl, book_price + book_page_count)

    book_cover_image = h.image_tag(book.medium_img_url)
    first_column = h.content_tag(:div, book_cover_image, {:class => "two columns"})
    second_column = h.content_tag(:div, book_title + author + data_list, {:class => "ten columns"})

    result_separator = h.content_tag(:hr)

    h.content_tag(:div, first_column + second_column + result_separator, {:class => "book-result"})
  end

end
