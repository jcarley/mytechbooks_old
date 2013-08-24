class Book
  include Mongoid::Document
  include Mongoid::Timestamps

  include Tire::Model::Search
  include Tire::Model::Callbacks

  include Kaminari::MongoidExtension::Criteria
  include Kaminari::MongoidExtension::Document

  field :title,            type: String
  field :author,           type: String
  field :ean,              type: String
  field :isbn,             type: String
  field :pages,            type: Integer
  field :binding,          type: String
  field :edition,          type: Integer
  field :formatted_price,  type: String
  field :asin,             type: String
  field :amount,           type: String
  field :details_url,      type: String
  field :description,      type: String
  field :small_img_url,    type: String
  field :medium_img_url,   type: String
  field :large_img_url,    type: String
  field :publisher,        type: String
  field :published_on,     type: Date

  validates :title, presence: true
  validates :isbn, presence: true

  belongs_to :user

  def to_indexed_json
    self.to_json
  end

  # TODO: Need to tie a search to the current_user
  def self.tire_search(criteria)
    return [] unless criteria.present?
    tire.search(load: true) do
      query { string criteria }
    end
  end

  # Product.tire.search :page => 1, :per_page => 100, :load => true do
     # query             { string "Ho ho" }
     #sort              { by     :rating, 'desc' }
  # end

  tire.mapping do
    indexes :id,           :index    => :not_analyzed
    indexes :user_id
    indexes :title,        :analyzer => 'snowball', :boost      => 100
    indexes :isbn,         :analyzer => 'keyword'
    indexes :description,  :analyzer => 'snowball'
    indexes :author,       :analyzer => 'keyword'
    indexes :publisher,    :analyzer => 'keyword'
    indexes :published_on, :type     => 'date', :include_in_all => false
  end

end
