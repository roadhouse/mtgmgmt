RSpec.configure do |config|
  config.after(:suite) do
    WebMock.disable_net_connect!(allow: %w{codeclimate.com})
  end
end
