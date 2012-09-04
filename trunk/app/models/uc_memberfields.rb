# -*- encoding : utf-8 -*-
class UcMemberfields < ActiveRecord::Base
  include ActiveBaseModel
  self.table_name =  'uc_memberfields'
  establish_connection :psvr_ucenter
end
