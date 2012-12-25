FactoryGirl.define do
  factory :book do
    title             "Service-Oriented Design with Ruby and Rails"
    ean               "9780321659361"
    isbn              "0321659368"
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
    publisher         "Addison-Wesley                                                                                                                                                                                                                                    Professional"
    published_on      "2012-12-16"
  end
end
