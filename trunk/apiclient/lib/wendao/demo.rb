# -*- encoding : utf-8 -*-
require 'sinatra/base'
require 'erb'
require 'wendao'
require 'wendao/version'
require 'net/http'
require 'active_support/core_ext'

if defined? Encoding
  Encoding.default_external = Encoding::UTF_8
end

module Wendao
  class Demo < Sinatra::Base
    
    require 'wendao/demo/config'
    
    dir = File.dirname(File.expand_path(__FILE__))
    set :views, "#{dir}/demo/views"
    configure(:development) { set :session_secret, "something" }
    
    if respond_to? :public_folder
      set :public_folder, "#{dir}/demo/public"
    else
      set :public, "#{dir}/demo/public"
    end
    set :static, true

    def show(page, layout = true)
      response["Cache-Control"] = "max-age=0, private, must-revalidate"
      begin
        erb page.to_sym, {:layout => layout}, :wendao => Wendao
      rescue Errno::ECONNREFUSED
        erb :error, {:layout => false}, :error => "Can't connect to Redis! (#{Wendao.redis_id})"
      end
    end

    def self.tabs
      @tabs ||= {"Overview"=>'首页', "OAuth"=>'用户认证', "Asks"=>'问题'}
    end
    def json_body
      @body = HashWithIndifferentAccess.new(JSON.parse(@ret))
    end
    
    enable :sessions
    
    # to make things easier on ourselves
    get "/?" do
      redirect url_path(:overview)
    end    

    get "/overview" do
      show :overview
    end
    
    get "/oauth" do
      show :oauth
    end
    
    get "/asks" do
      show :asks
    end
    def store_access_token
      if !@body[:access_token].blank?
        @title += " [成功,令牌已记录在您的session中]"
        session[:access_token] = @body[:access_token]
        session[:refresh_token] = @body[:refresh_token] if !@body[:refresh_token].blank?
      else
        @title += " [失败]"
      end
    end
    get '/redirect_receive' do
      @title = "令牌获取结果"
      @ret = ""
      uri = URI("#{SERVER_endpoint}/oauth/token")
      
      @res = Net::HTTP.start(uri.hostname, uri.port) do |http|
        http.post('/oauth/token',{
          "code"=> params[:code],
          "grant_type"=> "authorization_code",
          "redirect_uri"=> CLIENT_redirect,
          "client_id"=> CLIENT_client_id,
          "client_secret"=> CLIENT_client_secred
        }.to_json,{
          "Accept"=>"application/json",
          "Content-Type"=>"application/json"
        }) do |str|
          @ret += str
        end
      end
      json_body
      store_access_token
      show :result0
    end
    
    get '/oauth_refresh' do
      return "您还未获取访问令牌，请先获取。" if session[:refresh_token].blank?
      @title = "刷新访问令牌"
      @ret = ""
      uri = URI("#{SERVER_endpoint}/oauth/token")
      
      @res = Net::HTTP.start(uri.hostname, uri.port) do |http|
        http.post('/oauth/token',{
          "grant_type"=> "refresh_token",
          "refresh_token"=>session[:refresh_token],
          "redirect_uri"=> CLIENT_redirect,
          "client_id"=> CLIENT_client_id,
          "client_secret"=> CLIENT_client_secred
        }.to_json,{
          "Accept"=>"application/json",
          "Content-Type"=>"application/json"
        }) do |str|
          @ret += str
        end
      end
      
      json_body
      store_access_token
      show :result0
    end
    
    get "/exit" do
      session[:access_token] = nil
      session[:refresh_token] = nil
      redirect '/'
    end

    def wendao
      Wendao
    end
    
    
    
    helpers do
      include Rack::Utils
      alias_method :h, :escape_html
      def utf(arg)
        arg.force_encoding('UTF-8')
      end
      def current_section
        url_path request.path_info.sub('/','').split('/')[0].downcase
      end

      def current_page
        url_path request.path_info.sub('/','')
      end

      def url_path(*path_parts)
        [ path_prefix, path_parts ].join("/").squeeze('/')
      end
      alias_method :u, :url_path

      def path_prefix
        request.env['SCRIPT_NAME']
      end

      def class_if_current(path = '')
        'class="active"' if current_page[0, path.size] == path
      end

      def tab(name)
        dname = name.to_s.downcase
        path = url_path(dname)
        "<li #{class_if_current(path)}><a href='#{path}'>#{tabs[name]}</a></li>"
      end

      def tabs
        Wendao::Demo.tabs
      end
      
      def partial?
        @partial
      end

      def partial(template, local_vars = {})
        @partial = true
        erb(template.to_sym, {:layout => false}, local_vars)
      ensure
        @partial = false
      end
      
    end
  end
end
