class UserDecorator < Draper::Decorator
  decorates :user
  decorates_association :books

end
