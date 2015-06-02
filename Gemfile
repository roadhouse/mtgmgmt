source "https://rubygems.org"

gem "delayed_job_active_record"
gem "foreman"
gem "heroku"
gem "kaminari"
gem "nokogiri"
gem "pg"
gem "rabl"
gem "rails", "4.1.8"
gem "virtus"
gem "unicorn"

gem "rails_12factor", group: :production

group :development do
  gem "awesome_print"
  gem "guard-rspec", require: false
  gem "travis"
end

group :test, :development do
  gem "factory_girl_rails"
  gem "mocha", require: false
  gem "pry"
  gem "pry-rails"
  gem "pry-byebug"
  gem "rspec-rails"
end

group :test do
  gem "database_cleaner"
  gem "fuubar"
  gem "rspec-its"
  gem "vcr"
  gem "webmock"
end
