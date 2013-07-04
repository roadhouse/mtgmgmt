require "bundler"
Bundler.setup(:default, :test)

require "active_record"

require "rspec/matchers"
require "factory_girl"
require "shoulda-matchers"
require "mocha"


connection_info = YAML.load_file("config/database.yml")["test"]
ActiveRecord::Base.establish_connection(connection_info)
