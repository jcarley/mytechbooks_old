require 'spec_helper'

describe Amazon do

  it "should return one book" do
    api = Amazon.new
    books = api.search('0321659368')
    books.count.should eq(1)
  end

end
