class UcFriends < ActiveRecord::Base
  self.table_name =  'uc_friends'
  establish_connection :psvr_ucenter
end
