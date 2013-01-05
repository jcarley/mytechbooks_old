class BookDecorator < Draper::Base
  decorates :book

  def cover_image
    h.image_tag(book.medium_img_url)
  end

  def sub_title
    "#{book.author} (#{published_formatted_date})"
  end

  def published_formatted_date
    "#{book.published_on.strftime("%b %Y")}"
  end

end
