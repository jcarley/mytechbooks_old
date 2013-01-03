class BookDecorator < Draper::Base
  decorates :book

  def cover_image
    h.image_tag(book.medium_img_url)
  end

  def sub_title
    "#{book.author} (#{book.published_on.strftime("%b %Y")})"
  end

end
