require 'helper'

describe Wendao::Client do
  it 'should work with basic auth and password' do       
    stub_request(:get, "http://foo:bar@api.kejian.tv/users/user_myself/asks").
      with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => "", :headers => {})

    proc {
      Wendao::Client.new(:login => 'foo', :password => 'bar').user_asks('user_myself')
    }.should_not raise_exception
    
  end

  it "should traverse a paginated response if auto_traversal is on" do
    stub_get("https://api.kejian.tv/foo/bar").
      to_return(:status => 200, :body => %q{["stuff"]}, :headers => 
        { 'Link' => %q{<https://api.kejian.tv/foo/bar?page=2>; rel="next", <https://api.kejian.tv/foo/bar?page=3>; rel="last"} })

    stub_get("https://api.kejian.tv/foo/bar?page=2").
      to_return(:status => 200, :body => %q{["even more stuff"]}, :headers => 
        { 'Link' => %q{<https://api.kejian.tv/foo/bar?page=3>; rel="next", <https://api.kejian.tv/foo/bar?page=3>; rel="last", <https://api.kejian.tv/foo/bar?page=1>; rel="prev", <https://api.kejian.tv/foo/bar?page=1>; rel="first"} })

    stub_get("https://api.kejian.tv/foo/bar?page=3").
      to_return(:status => 200, :body => %q{["stuffapalooza"]}, :headers => 
        { 'Link' => %q{<https://api.kejian.tv/foo/bar?page=2>; rel="prev", <https://api.kejian.tv/foo/bar?page=1>; rel="first"} })

    Wendao::Client.new(:auto_traversal => true).get("https://api.kejian.tv/foo/bar", {}).should == ['stuff', 'even more stuff', 'stuffapalooza']
  end
end
