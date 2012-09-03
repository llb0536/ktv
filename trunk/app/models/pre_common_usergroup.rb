class PreCommonUsergroup < ActiveRecord::Base
  self.table_name =  'pre_common_usergroup'
  def self.inheritance_column
    'inheritance_type'
  end
end
