class BookDecorator < Draper::Decorator
  decorates :book
  delegate :id, :user_id, :title, :publisher, :binding, :pages, :isbn, :edition, :formatted_price, :details_url, :medium_img_url

  def cover_image
    model.medium_img_url
  end

  def sub_title
    "#{sanitized_author} (#{published_formatted_date})"
  end

  def published_formatted_date
    model.published_on.strftime("%b %Y")
  end

  def long_description
    model.description.nil? ? "No description at this time." : model.description.html_safe
  end

  def sanitized_author
    regex = /\[|\]|"/
    model.author.gsub(regex, '')
  end

end
