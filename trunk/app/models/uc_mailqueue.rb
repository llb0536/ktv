class UcMailqueue < ActiveRecord::Base
  set_table_name 'uc_mailqueue'
  establish_connection :psvr_ucenter
end
