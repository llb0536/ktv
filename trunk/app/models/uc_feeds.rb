class UcFeeds < ActiveRecord::Base
  set_table_name 'uc_feeds'
  establish_connection :psvr_ucenter
end
