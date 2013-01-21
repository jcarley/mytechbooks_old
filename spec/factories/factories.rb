FactoryGirl.define do

  factory :user do
    name 'John Doe'
    sequence(:email) {|n| "john.doe-#{n}@example.com" }
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

  factory :book do
    title             "Service-Oriented Design with Ruby and Rails"
    ean               "9780321659361"
    isbn              "0321659368"
    author            "Paul Dix"
    pages             250
    binding           "Paperback"
    edition           2
    formatted_price   "$49.99"
    asin              "0321659368"
    amount            '4999'
    details_url       "http://www.example.com/details"
    small_img_url     "http://www.example.com/images/small.jpg"
    medium_img_url    "http://www.example.com/images/medium.jpg"
    large_img_url     "http://www.example.com/images/large.jpg"
    publisher         "Addison-Wesley Professional"
    published_on      "2012-12-16"

    factory :book_with_user do
      user
    end
  end

end
