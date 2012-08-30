class UcPmIndexes < ActiveRecord::Base
  self.table_name =  'uc_pm_indexes'
  establish_connection :psvr_ucenter
end
