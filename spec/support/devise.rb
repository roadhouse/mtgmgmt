include Warden::Test::Helpers
Warden.test_mode!

RSpec.configure do |config|
  config.before(:suite) { Warden.test_mode! }
  config.include Devise::TestHelpers, type: :controller
  config.include Devise::TestHelpers, type: :view
  config.include Warden::Test::Helpers
end
