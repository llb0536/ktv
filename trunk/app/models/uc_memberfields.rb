class UcMemberfields < ActiveRecord::Base
  self.table_name =  'uc_memberfields'
  establish_connection :psvr_ucenter
end
