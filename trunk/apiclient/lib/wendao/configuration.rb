require 'faraday'
require 'wendao/version'

module Wendao
  module Configuration
    VALID_OPTIONS_KEYS = [
      :adapter,
      :api_endpoint,
      :login,
      :password,
      :proxy,
      :oauth_token,
      :user_agent,
      :auto_traversal].freeze

    DEFAULT_ADAPTER        = Faraday.default_adapter
    DEFAULT_API_ENDPOINT    = "http://api.zhaopin.com".freeze
    DEFAULT_USER_AGENT     = "Wendao Ruby Gem #{Wendao::VERSION}".freeze
    DEFAULT_AUTO_TRAVERSAL = false

    attr_accessor(*VALID_OPTIONS_KEYS)

    def self.extended(base)
      base.reset
    end

    def configure
      yield self
    end

    def options
      VALID_OPTIONS_KEYS.inject({}){|o,k| o.merge!(k => send(k)) }
    end

    def reset
      self.adapter        = DEFAULT_ADAPTER
      self.api_endpoint    = DEFAULT_API_ENDPOINT
      self.login          = nil
      self.password       = nil
      self.proxy          = nil
      self.oauth_token    = nil
      self.user_agent     = DEFAULT_USER_AGENT
      self.auto_traversal = DEFAULT_AUTO_TRAVERSAL
    end

  end
end