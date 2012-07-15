# Wendao

这是[智联招聘问道](http://wendao.zhaopin.com)[开放API](http://api.zhaopin.com/apidoc)的一个简单的Ruby类包装。

## 使用方法

```ruby
require 'rubygems'
=> true
require 'wendao'
=> true

herder = WendaoHerder.new
=> #<WendaoHerder:0x7f792d3c4918 ...>

me = herder.user 'jhelwig'
=> #<WendaoHerder::User:0x7f792d3b6070 ...>

me.html_url
=> "https://wendao.zhaopin.com/jhelwig"

me.available_attributes.sort
=> ["asks","topics",...]

repos = me.asks
=> [#<WendaoHerder::Ask:0x7f792d364bf8 ...>, #<WendaoHerder::Ask:0x7f792d364bd0 ..>, #<WendaoHerder::Ask:0x7f792d364ba8 ...>, ...]
```


## <a name="authenticated_requests"></a>如何进行认证？
对于那些需要认证的操作，你需要在初始化客户端的时候提供用户名和密码。

    client = Wendao::Client.new(:login => "me", :password => "secret")
    client.follow!("psvr")
    
或者，你可以使用你手中的访问令牌。注意：这个令牌**不是**你在[应用程序管理](http://api.zhaopin.com/clients)里看到的应用程序ID！而是通过用授权码换取访问令牌得到的那个字符串。

    client = Wendao::Client.new(:login => "me", :oauth_token => "oauth2token")
    client.follow!("psvr")


## 如何测试

Run `bundle exec rake spec`.

## Demo App

这个应用程序是一个用Sinatra开发的使用问道API的示例，基于Ruby客户端库wendao(http://rubygems.org/gems/wendao)。 

## 相关链接

	1. 问道：这是普通用户访问问道的地址，即问道主站。
	
	  http://wendao.zhaopin.com
	  
	2. 问道API：这是API用户访问问道的入口。
	
	  http://api.zhaopin.com
	  
	3. 问道API文档：此文档面向第三方应用程序开发者以及第三方库的开发者，详细记录了问道API的使用方法。
	
	  http://api.zhaopin.com/apidoc
	  
	4. 问道API第三方应用程序管理：面向第三方应用程序开发者，在此获得和管理访问问道API的客户端ID和密钥。
	
	  http://api.zhaopin.com/cpanel
	  
	5. Ruby客户端库：用Ruby实现的一个问道API客户端库。
	
	  http://rubygems.org/gems/wendao
	  
