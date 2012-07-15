# -*- encoding: utf-8 -*-
require 'helper'

describe Faraday::Response do
  before do
    @client = Wendao::Client.new
  end

  {
    400 => Wendao::BadRequest,
    401 => Wendao::Unauthorized,
    403 => Wendao::Forbidden,
    404 => Wendao::NotFound,
    406 => Wendao::NotAcceptable,
    422 => Wendao::UnprocessableEntity,
    500 => Wendao::InternalServerError,
    501 => Wendao::NotImplemented,
    502 => Wendao::BadGateway,
    503 => Wendao::ServiceUnavailable,
  }.each do |status, exception|
    context "when HTTP status is #{status}" do

      before do
        stub_request(:get, "http://api.zhaopin.com/users/psvr").
          with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
          to_return(:status => status, :body => "", :headers => {})
      end

      it "should raise #{exception.name} error" do
        lambda do
          @client.user('psvr')
        end.should raise_error(exception)
      end
    end
  end
end
