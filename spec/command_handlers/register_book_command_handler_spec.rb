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

  describe "public methods" do
    it { should respond_to(:execute) }
    it { should respond_to(:success?) }
    it { should respond_to(:error_message) }
  end

  describe "#execute" do

    context "with a valid isbn" do

      it "registers a book" do
        expect { subject.execute(user.id, valid_isbn) }.to change(user.books, :count).by(1)
      end

      it "returns a success status" do
        expect (subject.execute(user.id, valid_isbn).success?).should be_true
      end

      it "has an empty error message" do
        expect (subject.execute(user.id, valid_isbn).error_message).should be_nil
      end

    end

    context "with an invalid isbn" do

      it "does not register a book" do
        expect { subject.execute(user.id, invalid_isbn) }.to_not change(user.books, :count).by(1)
      end

      it "does not return a success status" do
        expect (subject.execute(user.id, invalid_isbn).success?).should be_false
      end

      it "does not have an error message" do
        expect (subject.execute(user.id, invalid_isbn).error_message).should_not be_nil
      end
    end

  end

end
