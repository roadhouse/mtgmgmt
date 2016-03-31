require "vcr"

RSpec.configure do
  VCR.configure do |c|
    c.default_cassette_options = {record: :once}
    c.ignore_hosts "codeclimate.com"
    c.cassette_library_dir = "spec/cassettes"
    c.configure_rspec_metadata!
    c.hook_into :webmock
  end
end
