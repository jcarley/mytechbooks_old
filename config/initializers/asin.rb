ASIN::Configuration.configure do |config|
  config.secret        = Figaro.env.aws_secret
  config.key           = Figaro.env.aws_key
  config.associate_tag = Figaro.env.aws_associate_tag
  config.logger        = Rails.env.test? ? nil : Rails.logger
end
