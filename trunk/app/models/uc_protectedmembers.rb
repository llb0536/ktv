class UcProtectedmembers < ActiveRecord::Base
  include ActiveBaseModel
  self.table_name =  'uc_protectedmembers'
  establish_connection :psvr_ucenter
end
