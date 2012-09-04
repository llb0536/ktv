# -*- encoding : utf-8 -*-
require 'open-uri'
class ErrorTrackerJob
  @queue = :error
  def self.perform(first,second)
    RestClient.post(Setting.error_tracker_url, {"SiteName"=>"wendao","Title"=>first,"Content"=>second,"AppId"=>"0","WebIp"=>"0","RemoteIp"=>"0"}.to_json, :content_type => :json, :accept => :json)
  end
end
