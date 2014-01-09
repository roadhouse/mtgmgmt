require 'vcr'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true

  VCR.configure do |c|
    c.cassette_library_dir = 'spec/cassettes'
    c.configure_rspec_metadata!
    c.hook_into :webmock
  end
end
