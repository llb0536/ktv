class UcMemberfields < ActiveRecord::Base
  set_table_name 'uc_memberfields'
  establish_connection :psvr_ucenter
end
