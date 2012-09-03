class UcMergemembers < ActiveRecord::Base
  include ActiveBaseModel
  self.table_name =  'uc_mergemembers'
  establish_connection :psvr_ucenter
end
