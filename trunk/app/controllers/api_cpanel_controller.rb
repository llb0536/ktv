class ApiCpanelController < ApplicationController
  layout 'oauth'
  before_filter :require_user
  def index
    
  end
protected
  def require_user
    if !current_user
      render 'require_user',:layout=>'oauth'
      return
    end
  end
end