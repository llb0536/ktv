class UcMembers < ActiveRecord::Base
  self.table_name =  'uc_members'
  establish_connection :psvr_ucenter
end
