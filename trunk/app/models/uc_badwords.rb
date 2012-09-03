class UcBadwords < ActiveRecord::Base
  include ActiveBaseModel
  self.table_name =  'uc_badwords'
  establish_connection :psvr_ucenter
end
