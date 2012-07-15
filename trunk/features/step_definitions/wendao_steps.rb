# coding: utf-8
require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

module WithinHelpers
  def with_scope(locator)
    locator ? within(*selector_for(locator)) { yield } : yield
  end
end
World(WithinHelpers)

Given /^I login with user (.+) and password (.+)$/ do |arg1, arg2|
  visit root_path
  click_link '登录'
  fill_in 'loginname', :with => arg1
  fill_in 'password', :with => arg2
  find_button('').click
end