class Book
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :author, type: String
  field :ean, type: String
  field :isbn, type: String
  field :pages, type: Integer
  field :binding, type: String
  field :edition, type: Integer
  field :formatted_price, type: String
  field :asin, type: String
  field :amount, type: String
  field :details_url, type: String
  field :small_img_url, type: String
  field :medium_img_url, type: String
  field :large_img_url, type: String
  field :publisher, type: String
  field :published_on, type: Date

  validates :title, presence: true
  validates :isbn, presence: true

  belongs_to :user

end
