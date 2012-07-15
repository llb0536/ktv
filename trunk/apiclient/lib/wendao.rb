# -*- encoding : utf-8 -*-
require 'wendao/configuration'
require 'wendao/client'
require 'wendao/error'

module Wendao
  extend Configuration
  class << self
    # Alias for Wendao::Client.new
    #
    # @return [Wendao::Client]
    def new(options={})
      Wendao::Client.new(options)
    end
    
    # Delegate to Api::Client.new
    def method_missing(method,*args,&block)
      return super unless new.respond_to?(method)
      new.send(method, *args, &block)
    end
    
    def respond_to?(method, include_private=false)
      new.respond_to?(method, include_private) | super(method, include_private)
    end
  end
end
