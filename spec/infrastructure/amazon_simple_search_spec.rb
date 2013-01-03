require 'spec_helper'

describe AmazonSimpleSearch, :vcr do

  let(:api) do
    AmazonSimpleSearch.new
  end

  let(:valid_criteria) do
    '0321659368'
  end

  let(:invalid_criteria) do
    '0987654321'
  end

  context :search do
    it "should return an array" do
      items = api.search(valid_criteria)
      items.should be_kind_of(Array)
    end

    it "should return one item" do
      items = api.search(valid_criteria)
      items.should have_exactly(1).items
    end

    it "should return an empty array" do
      items = api.search(invalid_criteria)
      items.should be_empty
    end

    specify { expect { |b| api.search(valid_criteria, &b) }.to yield_control }
    specify { expect { |b| api.search(invalid_criteria, &b) }.not_to yield_control }

  end

end
