class UcFeeds < ActiveRecord::Base
  self.table_name =  'uc_feeds'
  establish_connection :psvr_ucenter
end
