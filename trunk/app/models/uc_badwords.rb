class UcBadwords < ActiveRecord::Base
  set_table_name 'uc_badwords'
  establish_connection :psvr_ucenter
end
