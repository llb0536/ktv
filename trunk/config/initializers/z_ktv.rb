# -*- encoding : utf-8 -*-
module Ktv
  class << self
    attr_reader :config
  end
  # self.configure{} 这种配置方法是可重入的
  # 因此不必保证一次性就全部配置完成
  # 以后可以随时修改配置
  @config = OpenStruct.new
  def self.configure
    yield(@config)
  end
end


Ktv.configure do |config|
  if Rails.env.production?
    config.asset_host = 'http://ktv-intrinsic.b0.upaiyun.com'
  else
    config.asset_host = ''
  end
  config.redis = Redis::Search.config.redis
  config.consultants = [Ktv::Baidu,Ktv::Google]
  config.logger = Logger.new("#{Rails.root}/log/#{Rails.env}.ktv.log",File::WRONLY|File::APPEND)
  config.google_simple_api_key = 'AIzaSyBlxza4_3kcy8jzeAwWZOiIO4qAJl607FY'
  %w{user_agent
     open_timeout
     read_timeout
     idle_timeout
     mechanize_per_page
     timeout
     proxy}.each do |item|
    config.send(:"#{item}=",Setting.send(item))
  end
end

# c.f. /usr/local/lib/ruby/gems/1.9.1/gems/actionpack-3.2.6/lib/sprockets/helpers/rails_helper.rb  Line: 53/173:0                                                                    
module Sprockets
  module Helpers
    module RailsHelper
      alias_method :asset_path_before_psvr,:asset_path
      def asset_path(source, options = {})
        ret = asset_path_before_psvr(source, options)
        if ret.starts_with?('///')
          ret[2..-1]
        else
          ret
        end
      end
    end
  end
end
