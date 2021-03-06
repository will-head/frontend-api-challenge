require 'capybara/rspec'
require 'simplecov'
require 'simplecov-console'
require_relative '../app'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::Console,
  # Want a nice code coverage website? Uncomment this next line!
  # SimpleCov::Formatter::HTMLFormatter
])
SimpleCov.start

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :firefox)
end

# Enable to see tests in browser
Capybara.app = Chitter
Capybara.server = :puma, { Silent: true }
Capybara.default_driver = :selenium
# require File.join(File.dirname(__FILE__), '..', 'app.rb')
# Capybara.app = Chitter

RSpec.configure do |config|

  config.after(:suite) do
    puts
    puts "\e[33mHave you considered running rubocop? It will help you improve your code!\e[0m"
    puts "\e[33mTry it now! Just run: rubocop\e[0m"
  end

  ENV['RACK_ENV'] = 'test'
  
  require File.join(File.dirname(__FILE__), '..', 'app.rb')
  Capybara.app = Chitter
  
  # require 'features/web_helpers'
  
end
