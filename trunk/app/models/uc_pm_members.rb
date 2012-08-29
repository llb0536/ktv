class UcPmMembers < ActiveRecord::Base
  self.table_name =  'uc_pm_members'
  establish_connection :psvr_ucenter
end
