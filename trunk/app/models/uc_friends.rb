class UcFriends < ActiveRecord::Base
  include ActiveBaseModel
  self.table_name =  'uc_friends'
  establish_connection :psvr_ucenter
end
