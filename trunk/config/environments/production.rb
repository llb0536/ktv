Quora::Application.configure do
  # config.active_record.auto_explain_threshold_in_seconds = 0.5
  # config.log_tags = [ :subdomain, :uuid ]
  # config.logger = ActiveSupport::TaggedLogging.new(SyslogLogger.new)
  # Settings specified here will take precedence over those in config/application.rb
  config.active_support.deprecation = :notify
  
  # Code is not reloaded between requests
  config.cache_classes = true
 # config.cache_store = :memory_store, :size => 128.megabytes
  
  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = false

  # Disable Rails's static asset server (Apache or nginx will already do this)
  config.serve_static_assets = false
  
  config.action_mailer.smtp_settings = {
    :address => "192.168.1.46",
    :enable_starttls_auto => true,
    :port => 25,
    :domain => Setting.domain,
  # :authentication => :login,
  # :user_name => Setting.smtp_username,
  # :password => Setting.smtp_password,
    :openssl_verify_mode  => 'none'
  }
  
  config.action_mailer.delivery_method = :smtp
  
  # assets___________
  config.assets.debug = false
  config.assets.digest = true
  config.assets.compile = false
  config.assets.compress = true
  config.assets.css_compressor = 'sass-rails'
  config.assets.js_compressor = :uglifier
  config.assets.precompile += ['cpanel.js','cpanel.css','topics.js','html5.js','cpanel_oauth.css','cpanel_oauth.js','validationEngine.js','keditor/*']
  config.serve_static_assets = false
  # assets-----------
end
