class UcAdmins < ActiveRecord::Base
  self.table_name =  'uc_admins'
  establish_connection :psvr_ucenter
end
