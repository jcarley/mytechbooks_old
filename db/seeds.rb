# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts 'SETTING UP DEFAULT USER LOGIN'
user = User.create! name: 'Jefferson Carley', email: 'jcarley@example.com', password: 'password', password_confirmation: 'password'
user.add_role :admin
puts 'New user created: ' << user.name

book = Book.create! title: 'Service-Oriented Design with Ruby and Rails', author: 'Paul Dix', ean: '9780321659361', isbn: '0321659368', pages: 250, binding: 'Paperback',
  edition: 2, formatted_price: '$49.99', asin: '0321659368', amount: '4999', details_url: 'http://www.amazon.com/Service-Oriented-Design-Addison-Wesley-Professional-Series/dp/0321659368%3FSubscriptionId%3D12VVZFFGCXXK8A0B40G2%26tag%3Dwwwjefferso02-20%26linkCode%3Dxm2%26camp%3D2025%26creative%3D165953%26creativeASIN%3D0321659368',
  small_img_url: 'http://ecx.images-amazon.com/images/I/51VSl9L6DjL._SL75_.jpg', medium_img_url: 'http://ecx.images-amazon.com/images/I/51VSl9L6DjL._SL160_.jpg', large_img_url: 'http://ecx.images-amazon.com/images/I/51VSl9L6DjL.jpg',
  publisher: 'Addison-Wesley Professional', published_on: '2010-08-27'
user.books << book
user.save

user2 = User.create! name: 'Jaden Carley', email: 'jaden@example.com', password: 'password', password_confirmation: 'password'
puts 'New user created: ' << user2.name

