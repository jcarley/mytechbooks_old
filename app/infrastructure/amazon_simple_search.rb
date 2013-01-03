require 'asin'

class AmazonSimpleSearch
  include ASIN::Client

  def search(criteria)
    items = search_keywords(criteria, {:SearchIndex => :Books, :ResponseGroup => :Medium})
    if block_given?
      items = [] if items.nil?
      items.each do |item|
        yield item
      end
    else
      return items
    end
  end

end
