class UcNotelist < ActiveRecord::Base
  set_table_name 'uc_notelist'
  establish_connection :psvr_ucenter
end
