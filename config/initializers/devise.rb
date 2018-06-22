Devise.setup do |config|
  require 'devise/orm/active_record'

  config.case_insensitive_keys = [:email]
  config.expire_all_remember_me_on_sign_out = true
  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'
  config.omniauth :facebook, ENV["FACEBOOK_APP_ID"], ENV["FACEBOOK_APP_SECRET"]
  config.password_length = 8..72
  config.reconfirmable = true
  config.reset_password_within = 6.hours
  config.secret_key = '0b9084046574a4ff6646556831422494482c4508f35a365d4b81ed5be386db24b43c76181054ddd4e6d07a777bf8c69f33f21dd3af34b514f7d9fe7b98031af4'
  config.sign_out_via = :get
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 10
  config.strip_whitespace_keys = [:email]
end
