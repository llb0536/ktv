class UcDomains < ActiveRecord::Base
  include ActiveBaseModel
  self.table_name =  'uc_domains'
  establish_connection :psvr_ucenter
end
