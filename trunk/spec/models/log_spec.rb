#coding: utf-8
require 'spec_helper'

describe Log do
  it "when created, trigger LogbodyJob" do
    log = FactoryGirl.create(:ask_log_ADD_TOPIC)
    klass, args = resque_reserve_latest(:redundancy)
    klass.payload['class'].should eq 'LogbodyJob'
  end
end
