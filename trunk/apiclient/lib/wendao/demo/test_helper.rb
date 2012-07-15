# -*- encoding : utf-8 -*-
require 'rack/test'
require 'wendao/demo'

module Wendao
  module TestHelper
    class MiniTest::Unit::TestCase
      include Rack::Test::Methods
      def app
        Wendao::Demo.new
      end

      def self.should_respond_with_success
        it "should respond with success" do
          assert last_response.ok?, last_response.errors
        end
      end
    end
  end
end


