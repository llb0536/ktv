# -*- encoding : utf-8 -*-
class UcFeeds < ActiveRecord::Base
  include ActiveBaseModel
  self.table_name =  'uc_feeds'
  establish_connection :psvr_ucenter
end
