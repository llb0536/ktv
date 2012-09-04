# -*- encoding : utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
OauthAccess.delete_all
OauthAuthorization.delete_all
OauthNonce.delete_all
OauthRefreshToken.delete_all
OauthToken.delete_all

Scope.delete_all
Client.delete_all

@scope        = Scope.new
@scope.name   = 'all'
@scope.uri    = "http://kejian.tv/scopes/#{@scope.id}"
@scope.values = @scope.normalize("asks/index asks/show asks/create asks/update asks/destroy users/index users/show users/create users/update users/destroy")
@scope.save!

@client = Client.new
@client.name = "第三方应用程序示例"
@client.site_uri = "http://wendao.ofpsvr.org"
@client.redirect_uri = "http://wendao.ofpsvr.org/redirect_receive"
@client.info = '这个应用程序是一个用Sinatra开发的使用Kejian.TVAPI的示例，基于Ruby客户端库wendao(http://rubygems.org/gems/wendao)。 '
@client.user = User.admins.first
@client.uri          = "#{@client.id}"
@client.scope = ['all']
@client.scope_values = Oauth.normalize_scope(@client.scope.join(" "))
@client.save!
