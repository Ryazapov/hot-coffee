require "selenium/webdriver"

Capybara.register_driver :headless_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new(args: %w[disable-gpu headless window-size=1440,1280])

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.register_driver :chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new(args: %w[disable-gpu])

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.configure do |config|
  config.match = :prefer_exact
  config.javascript_driver = :headless_chrome
  config.default_max_wait_time = 5
  config.asset_host = "http://#{ENV.fetch('HOST')}"
end
