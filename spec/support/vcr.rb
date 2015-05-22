require 'vcr'

RSpec.configure do |config|
  VCR.configure do |c|
    c.cassette_library_dir = 'spec/cassettes'
    c.configure_rspec_metadata!
    c.hook_into :webmock
  end
end
