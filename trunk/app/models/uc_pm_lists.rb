class UcPmLists < ActiveRecord::Base
  set_table_name 'uc_pm_lists'
  establish_connection :psvr_ucenter
end
