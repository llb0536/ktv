class UcVars < ActiveRecord::Base
  include ActiveBaseModel
  self.table_name =  'uc_vars'
  establish_connection :psvr_ucenter
end
