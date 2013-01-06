class BookDecorator < Draper::Base
  decorates :book

  denies :description

  def cover_image
    h.image_tag(book.medium_img_url)
  end

  def sub_title
    "#{book.author} (#{published_formatted_date})"
  end

  def published_formatted_date
    "#{book.published_on.strftime("%b %Y")}"
  end

  def long_description
    book.description.nil? ? "No description at this time." : book.description.html_safe
  end

end
