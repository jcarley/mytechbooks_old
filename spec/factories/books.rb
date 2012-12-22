# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :book do
    title "MyString"
    publisher "MyString"
    published_on "2012-12-16"
  end
end
