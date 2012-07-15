require 'wendao/authentication'
require 'wendao/connection'
require 'wendao/request'

require 'wendao/client/asks'
require 'wendao/client/users'

module Wendao
  class Client
    attr_accessor(*Configuration::VALID_OPTIONS_KEYS)

    def initialize(options={})
      options = Wendao.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    include Wendao::Authentication
    include Wendao::Connection
    include Wendao::Request

    include Wendao::Client::Asks
    include Wendao::Client::Users
  end
end