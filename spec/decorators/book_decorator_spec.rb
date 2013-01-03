require 'spec_helper'

describe BookDecorator do
  let (:book) do
    FactoryGirl.create(:book)
  end

  let (:decorator) do
    BookDecorator.decorate(book)
  end

  subject { decorator }

  it { should respond_to :cover_image }
  it { should respond_to :sub_title }

end
