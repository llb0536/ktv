# coding: utf-8
require 'spec_helper'

describe "LogbodyJob" do
  it "should fill the body of some log" do
    log = FactoryGirl.create(:ask_log_ADD_TOPIC)
    Resque.enqueue(LogbodyJob,log_id:log.id)
    job = resque_reserve_latest(:redundancy)
    klass = Resque::Job.constantize(job.payload['class'])
    job.payload['args'].first['log_id'].should eq log.id.to_s
    klass.perform(*job.payload['args'])
    log.reload
    log.body.should_not be_empty
  end
end
