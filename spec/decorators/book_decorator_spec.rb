require 'spec_helper'

describe BookDecorator do
  let (:book) do
    FactoryGirl.create(:book)
  end

  let (:decorator) do
    BookDecorator.decorate(book)
  end

  subject { decorator }

  it { should respond_to :result }

  # .two.columns
    # img src="http://placehold.it/1000x1000&text=Thumbnail"
  # .ten.columns
    # h5 Item Name
    # h6.subheader Freddy George (Dec 2011)
    # dl
      # dd MSRP: $100.00
      # dd Pages: 345
  # hr
  context :result do

    let(:markup) do
      result = decorator.result
      Capybara.string(result)
    end

    subject { markup }

    it { should have_css("div[class='two columns']") }
    it { should have_css("div[class='ten columns']") }
    it { should have_css("hr") }
    it { should have_content("MSRP") }
    it { should have_content("Pages") }

  end
end
