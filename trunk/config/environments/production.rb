Quora::Application.configure do
  # config.active_record.auto_explain_threshold_in_seconds = 0.5
  # config.log_tags = [ :subdomain, :uuid ]
  # config.logger = ActiveSupport::TaggedLogging.new(SyslogLogger.new)
  # Settings specified here will take precedence over those in config/application.rb
  config.active_support.deprecation = :notify
  config.i18n.fallbacks = true  
  # Code is not reloaded between requests
  config.cache_classes = true
  config.cache_store = :dalli_store, 'localhost'
      { :namespace => 'ktv', :expires_in => 1.day, :compress => true }
 # config.cache_store = :memory_store, :size => 128.megabytes
  
  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Disable Rails's static asset server (Apache or nginx will already do this)
  config.serve_static_assets = false
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    :address              => 'smtp.gmail.com',
    :port                 => 587,
    :domain               => 'kejian.tv',
    :user_name            => 'kejian.tv@gmail.com',
    :password             => 'jknlff8-pro-17m7755',
    :authentication       => 'plain',
    :enable_starttls_auto => true  
  }
  Mongoid.configure do |config|
    config.logger = nil
  end
  # assets___________
  config.assets.manifest = "/home/main/ktv/_assets"
  config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for nginx
  config.assets.debug = false
  config.assets.digest = true
  config.assets.compile = false
  config.assets.compress = true
  config.assets.css_compressor = 'sass-rails'
  config.assets.js_compressor = :uglifier
  config.assets.precompile += %w{
    ktv/ie/application.js
    ktv/ie/application.css
    ktv/embed.js
    ktv/ppt.css
    ktv/player_ppt.js
    ktv/s.player.js
    ktv/ie.css
    ktv/ie7.css
    ktv/ie6.css
    ktv/__zm_sur.css
    ktv/__zm_hoth.css
    ktv/__zm_ban.css
    ktv/__zm_dar.css
    ktv/__zm_user.css
    ktv/__zm_friend.css
    ktv/__zm_dialog.css
    ktv/__kug.css

    cpanel.js
    cpanel.css
    topics.js
    html5.js
    cpanel_oauth.css
    cpanel_oauth.js
    validationEngine.js
    keditor/*
    about.css
    css_ie.css
  }
  # 别忘了同时修改:
  # config/initializers/z_ktv.rb
  config.action_controller.asset_host = 'http://ktv-intrinsic.b0.upaiyun.com'
  config.assets.prefix = ''
  # assets-----------
  config.action_mailer.raise_delivery_errors = false
  config.whiny_nils = false

# THIS ｉＳ only TMP!!!!!!  =begin
  config.cache_classes = false
  config.consider_all_requests_local       = true
  config.action_mailer.raise_delivery_errors = true
  config.whiny_nils = true
  config.assets.compress = false
  config.assets.debug = true
  config.action_controller.asset_host = nil
  config.assets.prefix = '/assets'
  config.assets.manifest =nil
  config.assets.digest = false
  config.assets.compile = true
  config.serve_static_assets = true
  config.consider_all_requests_local = true
  config.cache_store = :file_store, "#{Rails.root}/tmp/cache/"
# THIS ｉＳ only TMP!!!!!!  =end
end
