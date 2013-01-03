require 'spec_helper'

describe RegisterBookCommandHandler, :vcr do

  subject { RegisterBookCommandHandler.new }

  let(:user) do
    FactoryGirl.create(:user_with_books)
  end

  let(:valid_isbn) do
    "9781430219972"
  end

  let(:invalid_isbn) do
    "9781430219999"
  end

  it { should respond_to(:execute) }

  specify { expect { subject.execute(user.id, valid_isbn)   }.to     change{user.books.count}.by(1) }
  specify { expect { subject.execute(user.id, invalid_isbn) }.to_not change{user.books.count}.by(1) }

  specify { expect ( subject.execute(user.id, valid_isbn)   ).should be_true  }
  specify { expect ( subject.execute(user.id, invalid_isbn) ).should be_false }

  specify { expect { |b| subject.execute(user.id, valid_isbn, &b)   }.to yield_control }
  specify { expect { |b| subject.execute(user.id, invalid_isbn, &b) }.to yield_control }

  it "should not return an error message" do
    subject.execute(user.id, valid_isbn) do |result|
      result[:success].should be_true
      result[:error].should be_nil
    end
  end

  it "should return an error message" do
    subject.execute(user.id, invalid_isbn) do |result|
      result[:success].should be_false
      result[:error].should match(/Error: Unable to register book/)
    end
  end
end
