unless ENV['CI']
  require 'simplecov'
  SimpleCov.start do
    add_filter "/spec"
  end
end
require 'wendao'
require 'rspec'
require 'webmock/rspec'
require 'pry'

def a_delete(url)
  a_request(:delete, zhaopin_url(url))
end

def a_get(url)
  a_request(:get, zhaopin_url(url))
end

def a_patch(url)
  a_request(:patch, zhaopin_url(url))
end

def a_post(url)
  a_request(:post, zhaopin_url(url))
end

def a_put(url)
  a_request(:put, zhaopin_url(url))
end

def stub_delete(url)
  stub_request(:delete, zhaopin_url(url))
end

def stub_get(url)
  stub_request(:get, zhaopin_url(url))
end

def stub_patch(url)
  stub_request(:patch, zhaopin_url(url))
end

def stub_post(url)
  stub_request(:post, zhaopin_url(url))
end

def stub_put(url)
  stub_request(:put, zhaopin_url(url))
end

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end

def zhaopin_url(url)
  if url =~ /^http/
    url
  elsif @client && @client.authenticated?
    "https://pengwynn%2Ftoken:OU812@api.zhaopin.com#{url}"
  elsif @client && @client.oauthed?
    "https://api.zhaopin.com#{url}?access_token=#{@client.oauth_token}"
  else
    "https://api.zhaopin.com#{url}"
  end
end
