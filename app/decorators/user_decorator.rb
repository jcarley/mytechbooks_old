class UserDecorator < Draper::Base
  decorates :user
  decorates_association :books

end
