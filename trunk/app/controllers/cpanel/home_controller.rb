# -*- encoding : utf-8 -*-
class Cpanel::HomeController < CpanelController
  def index
    redirect_to '/cpanel/users'
  end
end
