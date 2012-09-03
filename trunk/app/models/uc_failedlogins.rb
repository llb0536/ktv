class UcFailedlogins < ActiveRecord::Base
  include ActiveBaseModel
  self.table_name =  'uc_failedlogins'
  establish_connection :psvr_ucenter
end
