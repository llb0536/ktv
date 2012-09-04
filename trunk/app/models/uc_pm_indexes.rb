# -*- encoding : utf-8 -*-
class UcPmIndexes < ActiveRecord::Base
  include ActiveBaseModel
  self.table_name =  'uc_pm_indexes'
  establish_connection :psvr_ucenter
end
