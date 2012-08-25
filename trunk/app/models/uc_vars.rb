class UcVars < ActiveRecord::Base
  set_table_name 'uc_vars'
  establish_connection :psvr_ucenter
end
