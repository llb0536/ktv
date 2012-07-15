require File.expand_path('../boot', __FILE__)



require "action_controller/railtie"
require "action_mailer/railtie"
require "active_resource/railtie"
require "sprockets/railtie"



# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
# Bundler.require(:default, Rails.env) if defined?(Bundler)
if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(:assets => %w(development test)))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end


class RedisSetting < Settingslogic  
  source File.expand_path('../redis.yml', __FILE__)
  namespace Rails.env
  suppress_errors Rails.env.production?
end

class Setting < Settingslogic
  source File.expand_path('../setting.yml', __FILE__)
  namespace Rails.env
  suppress_errors Rails.env.production?
end



module Quora
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    config.autoload_paths += ["#{config.root}/uploaders", "#{Rails.root}/lib/cryptor", "#{Rails.root}/lib/core_ext"]
    config.action_mailer.default_url_options = {:host => Setting.ktv_domain}
    config.action_controller.default_url_options = {:host => Setting.ktv_domain}
    config.action_controller.page_cache_directory= File.expand_path('./html_cache',Rails.root)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer
    # config.mongoid.observers = :ask_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Beijing'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = 'zh-CN'
    config.i18n.available_locales = ['zh-CN', :en]

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

		# TODO: 禁用 Mongoid Logger，因为他的日志输出会造成 mongoid-sphinx 的 XML 生成里面多出查询日志, 这里需要改用别的输出代替
    # config.mongoid.logger = Logger.new($stdout, :warn)

    # Enable the asset pipeline
    config.assets.enabled = true
    config.assets.version = '1.0'
    config.action_controller.asset_host = nil
    #config.middleware.use ::Rack::PerftoolsProfiler, :default_printer => 'gif', :bundler => true, :password=>'zhaopin3707'
    # require 'oauth/rack/oauth_filter'
    # config.middleware.use OAuth::Rack::OAuthFilter
    # Use SQL instead of Active Record's schema dumper when creating the database.

    # This is necessary if your schema can't be completely dumped by the schema dumper,

    # like if you have constraints or database-specific column types

    # config.active_record.schema_format = :sql


    # Enforce whitelist mode for mass assignment.

    # This will create an empty whitelist of attributes available for mass-assignment for all models

    # in your app. As such, your models will need to explicitly whitelist or blacklist accessible

    # parameters by using an attr_accessible or attr_protected declaration.

    # config.active_record.whitelist_attributes = false #todo: security concerns
    config.active_support.escape_html_entities_in_json = true
  end
end

require "string_extensions"
require "array_extensions"
require "zomet"
require "mmseg"
require 'will_paginate/array'
