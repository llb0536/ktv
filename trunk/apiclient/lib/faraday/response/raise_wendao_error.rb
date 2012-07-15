require 'faraday'
require 'multi_json'

module Faraday
  class Response::RaiseWendaoError < Response::Middleware
    def on_complete(response)
      case response[:status].to_i
      when 400
        raise Wendao::BadRequest, error_message(response)
      when 401
        raise Wendao::Unauthorized, error_message(response)
      when 403
        raise Wendao::Forbidden, error_message(response)
      when 404
        raise Wendao::NotFound, error_message(response)
      when 406
        raise Wendao::NotAcceptable, error_message(response)
      when 422
        raise Wendao::UnprocessableEntity, error_message(response)
      when 500
        raise Wendao::InternalServerError, error_message(response)
      when 501
        raise Wendao::NotImplemented, error_message(response)
      when 502
        raise Wendao::BadGateway, error_message(response)
      when 503
        raise Wendao::ServiceUnavailable, error_message(response)
      end
    end

    def error_message(response)
      message = if ( body = response[:body] ) && !body.empty?
        if body.is_a? String
          body = ::MultiJson.decode body, :symbolize_keys => true
        end
        ": #{body[:error] || body[:message] || ''}"
      else
        ''
      end
      "#{response[:method].to_s.upcase} #{response[:url].to_s}: #{response[:status]}#{message}"
    end
  end
end
