class UcMergemembers < ActiveRecord::Base
  set_table_name 'uc_mergemembers'
  establish_connection :psvr_ucenter
end
