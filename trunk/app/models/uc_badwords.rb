class UcBadwords < ActiveRecord::Base
  self.table_name =  'uc_badwords'
  establish_connection :psvr_ucenter
end
