class Book < ActiveRecord::Base
  attr_accessible :amount, :asin, :author, :binding, :description, :details_url, :ean, :edition, :formatted_price, :isbn, :large_img_url, :medium_img_url, :pages, :published_on, :publisher, :small_img_url, :title

  validates :title, presence: true
  validates :isbn, presence: true

  belongs_to :user
end
