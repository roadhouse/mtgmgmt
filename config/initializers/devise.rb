Devise.setup do |config|
  require 'devise/orm/active_record'

  config.case_insensitive_keys = [:email]
  config.expire_all_remember_me_on_sign_out = true
  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'
  config.omniauth :facebook, ENV["facebook_app_id"], ENV["facebook_app_secret"]
  config.password_length = 8..72
  config.reconfirmable = true
  config.reset_password_within = 6.hours
  config.sign_out_via = :get
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 10
  config.strip_whitespace_keys = [:email]
end
