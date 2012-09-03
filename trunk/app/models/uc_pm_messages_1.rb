class UcPmMessages1 < ActiveRecord::Base
  include ActiveBaseModel
  self.table_name =  'uc_pm_messages_1'
  establish_connection :psvr_ucenter
end
