require 'cucumber/rails'
require 'capybara/poltergeist'
require 'rspec/expectations'

World(RSpec::Matchers)


ActionController::Base.allow_rescue = false

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, {
    :inspector => true,
    :phantomjs_options => ['--web-security=true']
  })
end

Capybara.configure do |config|
  config.default_selector = :css
  config.javascript_driver = :poltergeist
end

begin
  DatabaseCleaner.orm = 'mongoid'
  DatabaseCleaner.strategy = :truncation
rescue NameError
  raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
end

Cucumber::Rails::Database.javascript_strategy = :truncation
