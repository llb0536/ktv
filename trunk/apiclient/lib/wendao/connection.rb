require 'faraday_middleware'
require 'faraday/response/raise_wendao_error'

module Wendao
  # @private
  module Connection
    private

    def connection(authenticate=true, raw=false, endpoint=Wendao::Configuration::DEFAULT_API_ENDPOINT, force_urlencoded=false)
      url = endpoint

      options = {
        :proxy => proxy,
        :ssl => { :verify => false },
        :url => url,
      }

      options.merge!(:params => {:access_token => oauth_token}) if oauthed? && !authenticated?

      connection = Faraday.new(options) do |builder|
        if !force_urlencoded
          builder.use Faraday::Request::JSON
        else
          builder.use Faraday::Request::UrlEncoded
        end
        builder.use Faraday::Response::RaiseWendaoError
        unless raw
          builder.use FaradayMiddleware::Mashify
          builder.use FaradayMiddleware::ParseJson
        end
        builder.adapter(adapter)
      end
      connection.basic_auth authentication[:login], authentication[:password] if authenticate and authenticated?
      connection
    end
  end
end
