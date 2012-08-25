class UcFriends < ActiveRecord::Base
  set_table_name 'uc_friends'
  establish_connection :psvr_ucenter
end
