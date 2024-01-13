# spec/support/capybara.rb

require 'capybara/rspec'

Capybara.default_driver = :selenium_chrome_headless
Capybara.javascript_driver = :selenium_chrome_headless
Capybara.server = :puma, { Silent: true }
