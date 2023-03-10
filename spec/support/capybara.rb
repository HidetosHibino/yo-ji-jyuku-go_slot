require 'capybara/rspec'

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :selenium, using: :headless_chrome, options: {
      browser: :remote,
      url: ENV.fetch("SELENIUM_DRIVER_URL"),
      desired_capabilities: :chrome
    }
    Capybara.server_host = 'web'
    Capybara.app_host="http://#{Capybara.server_host}"
  end
end


Capybara.configure do |config|

  config.default_driver = :chrome
  config.javascript_driver = :chrome
  config.run_server = true
  config.default_selector = :css 
  config.default_max_wait_time = 5  
  config.ignore_hidden_elements = true
  config.save_path = Dir.pwd     
  config.automatic_label_click = false 
end

Capybara.register_driver :chrome do |app|

  options = Selenium::WebDriver::Chrome::Options.new

  options.add_argument('disable-notifications')       
  options.add_argument('disable-translate')          
  options.add_argument('disable-extensions')         
  options.add_argument('disable-infobars')           
  options.add_argument('window-size=1280,960')        


  # ブラウザーを起動する
  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options: options)
end