class User < ActiveRecord::Base
  include Clearance::User

  attr_accessible :first_name, :last_name, :email, :encrypted_password, :confirmation_token, :remember_token

  validates :first_name, :presence => true,
                         :length => { :maximum => 50 }
  validates :last_name, :presence => true,
                         :length => { :maximum => 50 }
  validates :email, :presence => true
  validates :encrypted_password, :presence => true

  rolify

  # has_many :books

  # def register_book(book)
    # self.books << book unless book.nil?
  # end
end
