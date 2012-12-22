ASIN::Configuration.configure do |config|
  config.secret        = 'n+iIEHLuhkGGTijsME5ac6dXDyrMt59QXqk9k3YD'
  config.key           = '12VVZFFGCXXK8A0B40G2'
  config.associate_tag = 'wwwjefferso02-20'
  config.logger        = Rails.env.test? ? nil : Rails.logger
end
