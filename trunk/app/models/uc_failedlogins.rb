class UcFailedlogins < ActiveRecord::Base
  set_table_name 'uc_failedlogins'
  establish_connection :psvr_ucenter
end
