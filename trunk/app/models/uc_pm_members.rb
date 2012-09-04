# -*- encoding : utf-8 -*-
class UcPmMembers < ActiveRecord::Base
  include ActiveBaseModel
  self.table_name =  'uc_pm_members'
  establish_connection :psvr_ucenter
end
