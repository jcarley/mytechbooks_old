FactoryGirl.define do

  factory :user do
    name 'John Doe'
    email 'john.doe@example.com'
    password 'password'
    password_confirmation 'password'
    # required if the Devise Confirmable module is used
    # confirmed_at Time.now

    factory :user_with_books do

      ignore do
        book_count 1
      end

      after(:create) do |user, evaluator|
        FactoryGirl.create_list(:book, evaluator.book_count, user: user)
      end

    end
  end
end
