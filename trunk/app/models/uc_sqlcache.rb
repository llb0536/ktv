class UcSqlcache < ActiveRecord::Base
  self.table_name =  'uc_sqlcache'
  establish_connection :psvr_ucenter
end
