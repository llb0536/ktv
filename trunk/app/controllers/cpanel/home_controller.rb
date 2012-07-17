class Cpanel::HomeController < CpanelController
  def index
    redirect_to '/cpanel/user/avatar_admin'
  end
end
