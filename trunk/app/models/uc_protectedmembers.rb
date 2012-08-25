class UcProtectedmembers < ActiveRecord::Base
  set_table_name 'uc_protectedmembers'
  establish_connection :psvr_ucenter
end
