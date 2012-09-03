class UcMembers < ActiveRecord::Base
  include ActiveBaseModel
  self.table_name =  'uc_members'
  establish_connection :psvr_ucenter
end
