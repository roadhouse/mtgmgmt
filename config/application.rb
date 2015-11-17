require File.expand_path('../boot', __FILE__)

require 'rails/all'

if defined?(Bundler)
  Bundler.require(*Rails.groups(:assets => %w(development test)))
end

module Magic
  class Application < Rails::Application
    config.active_support.escape_html_entities_in_json = true
    config.autoload_paths += Dir["#{config.root}/lib/**/"]
    config.encoding = "utf-8"
    config.filter_parameters += [:password]
    config.generators.request_specs = false
    config.generators.routing_specs = false
    config.generators.view_specs = false
    config.watchable_dirs['lib'] = [:rb]
  end
end
