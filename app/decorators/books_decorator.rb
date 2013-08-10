class BooksDecorator < Draper::CollectionDecorator
  delegate :id, :user_id, :current_page, :total_count, :total_pages, :limit_value, :model_name
end
