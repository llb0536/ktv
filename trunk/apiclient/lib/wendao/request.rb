require 'multi_json'

module Wendao
  module Request
    def delete(path, options={}, endpoint=api_endpoint, authenticate=true, raw=false, force_urlencoded=false)
      request(:delete, path, options, endpoint, authenticate, raw, force_urlencoded)
    end

    def get(path, options={}, endpoint=api_endpoint, authenticate=true, raw=false, force_urlencoded=false)
      request(:get, path, options, endpoint, authenticate, raw, force_urlencoded)
    end

    def patch(path, options={}, endpoint=api_endpoint, authenticate=true, raw=false, force_urlencoded=false)
      request(:patch, path, options, endpoint, authenticate, raw, force_urlencoded)
    end

    def post(path, options={}, endpoint=api_endpoint, authenticate=true, raw=false, force_urlencoded=false)
      request(:post, path, options, endpoint, authenticate, raw, force_urlencoded)
    end

    def put(path, options={}, endpoint=api_endpoint, authenticate=true, raw=false, force_urlencoded=false)
      request(:put, path, options, endpoint, authenticate, raw, force_urlencoded)
    end

    private

    def request(method, path, options, endpoint, authenticate, raw, force_urlencoded)
      response = connection(authenticate, raw, endpoint, force_urlencoded).send(method) do |request|
        case method
        when :delete, :get
          request.url(path, options)
        when :patch, :post, :put
          request.path = path
          if !force_urlencoded
            request.body = MultiJson.encode(options) unless options.empty?
          else
            request.body = options unless options.empty?
          end
        end
      end

      if raw
        response
      elsif auto_traversal && ( next_url = links(response)["next"] )
        response.body + request(method, next_url, options, endpoint, authenticate, raw, force_urlencoded)
      else
        response.body
      end
    end

    def links(response)
      links = ( response.headers["Link"] || "" ).split(', ').map do |link|
        url, type = link.match(/<(.*?)>; rel="(\w+)"/).captures
        [ type, url ]
      end

      Hash[ *links.flatten ]
    end
  end
end
