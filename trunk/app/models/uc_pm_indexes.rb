class UcPmIndexes < ActiveRecord::Base
  set_table_name 'uc_pm_indexes'
  establish_connection :psvr_ucenter
end
