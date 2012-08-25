class UcAdmins < ActiveRecord::Base
  set_table_name 'uc_admins'
  establish_connection :psvr_ucenter
end
