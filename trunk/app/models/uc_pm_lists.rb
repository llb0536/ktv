class UcPmLists < ActiveRecord::Base
  include ActiveBaseModel
  self.table_name =  'uc_pm_lists'
  establish_connection :psvr_ucenter
end
