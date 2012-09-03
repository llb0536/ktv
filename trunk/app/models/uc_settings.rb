class UcSettings < ActiveRecord::Base
  include ActiveBaseModel
  self.table_name =  'uc_settings'
  establish_connection :psvr_ucenter
end
