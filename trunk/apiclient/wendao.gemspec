# encoding: utf-8
require File.expand_path('../lib/wendao/version', __FILE__)

Gem::Specification.new do |gem|
  gem.add_dependency 'addressable', '~> 2.2'
  gem.add_dependency 'faraday', '~> 0.7'
  gem.add_dependency 'faraday_middleware', '~> 0.8'
  gem.add_dependency 'hashie', '~> 1.2'
  gem.add_dependency 'multi_json', '~> 1.0'
  gem.add_dependency "sinatra",         ">= 0.9.2"
  gem.add_dependency "activesupport"
  gem.add_development_dependency 'pry'
  gem.add_development_dependency 'shotgun'
  gem.add_development_dependency 'json'
  gem.add_development_dependency 'maruku'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec', '~> 2.8'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'webmock'
  gem.add_development_dependency 'yard'
  
  gem.authors = ["Minqi Pan", "Yunlong Lee"]
  gem.description = %q{Simple Ruby wrapper for wendao API}
  gem.email = ['pmq2001@gmail.com', 'yunlong.li@zhaopin.com.cn']
  gem.files = `git ls-files`.split("\n")
  gem.homepage = 'https://github.com/pmq20/wendao'
  gem.name = 'wendao'
  gem.platform = Gem::Platform::RUBY
  gem.require_paths = ['lib']
  gem.required_rubygems_version = Gem::Requirement.new('>= 1.3.6')
  gem.summary = %q{Wrapper for the Wendao API}
  gem.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.version = Wendao::VERSION.dup
end
