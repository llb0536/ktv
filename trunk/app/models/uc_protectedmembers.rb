class UcProtectedmembers < ActiveRecord::Base
  self.table_name =  'uc_protectedmembers'
  establish_connection :psvr_ucenter
end
