require "bundler"
require "yaml"
Bundler.setup(:default, :test)

require "active_record"

require "rspec/matchers"
require "factory_girl"
require 'rspec/its'

connection_info = YAML.load_file("config/database.yml")["test"]
ActiveRecord::Base.establish_connection(connection_info)


# Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.order = "random"
end
