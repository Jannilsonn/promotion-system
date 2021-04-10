require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400]
end

# if ENV["SLOW"].present?
#   require "selenium-webdriver"
#   module ::Selenium::WebDriver::Remote
#     class Bridge
#       alias old_execute execute

#       def execute(*args)
#         sleep(0.3)
#         old_execute(*args)
#       end
#     end
#   end
# end
