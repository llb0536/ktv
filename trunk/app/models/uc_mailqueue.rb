class UcMailqueue < ActiveRecord::Base
  include ActiveBaseModel
  self.table_name =  'uc_mailqueue'
  establish_connection :psvr_ucenter
end
