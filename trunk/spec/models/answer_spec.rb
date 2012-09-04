# -*- encoding : utf-8 -*-
#coding: utf-8
require 'spec_helper'

describe Answer do
  it "under the same ask, when created, can not then create again" do
    user = $_users[1]
    @ask = $_asks[11]
    @ask.answer('hahaha',user)[0].should be_true
    @ask.answer('hahaha again',user)[0].should be_false
  end


  it "under the same ask, when created and then deleted, can then create again" do
    user = $_users[0]
    @ask = $_asks[10]
    @ask.answer('hahaha',user)[0].should be_true
    @ask.reload
    @ask.last_answer.soft_delete
    @ask.answer('hahaha',user)[0].should be_true
  end
  
  # it "when created, trigger Askbody2Job on its ask" do
  #   answer = FactoryGirl.create(:answer)
  #   job = resque_reserve_latest(:redundancy)
  #   job.payload['class'].should eq 'Askbody2Job'
  #   job.payload['args'].first['ask_id'].should eq answer.ask.id.to_s
  # end
  
end
