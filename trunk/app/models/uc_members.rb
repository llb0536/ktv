class UcMembers < ActiveRecord::Base
  set_table_name 'uc_members'
  establish_connection :psvr_ucenter
end
