RSpec.configure do |config|
  VCR.configure do |c|
    c.cassette_library_dir = 'vcr_cassettes'
    c.hook_into :webmock
  end
end
