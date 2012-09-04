# -*- encoding : utf-8 -*-
class UcSqlcache < ActiveRecord::Base
  include ActiveBaseModel
  self.table_name =  'uc_sqlcache'
  establish_connection :psvr_ucenter
end
