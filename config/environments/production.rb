Magic::Application.configure do
  config.action_controller.perform_caching = true
  config.active_support.deprecation = :notify
  config.cache_classes = true
  config.consider_all_requests_local = false
  config.eager_load = true
  config.i18n.fallbacks = true
  config.log_level = :info
  config.serve_static_files = false
end
