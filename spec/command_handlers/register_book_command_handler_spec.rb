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
    "9781480219999"
  end

  describe "public methods" do
    it { should respond_to(:execute) }
  end

  describe "#execute" do

    context "with a valid isbn" do

      it "registers a book" do
        expect { subject.execute(user.id, valid_isbn) }.to change(user.books, :count).by(1)
      end

    end

    context "with an invalid isbn" do

      it "does not register a book" do
        expect { subject.execute(user.id, invalid_isbn) }.to_not change(user.books, :count).by(1)
      end

    end

  end

end
