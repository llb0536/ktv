# -*- encoding : utf-8 -*-
module Ktv
  class Discuz
    extend Ktv::Helpers::Config
    include Ktv::Helpers::Config
    include Shared::MechanizeParty
    def login!(username,password)
      # 依赖于forum.php显示登陆框框
      @login_page = @agent.get("http://#{Setting.ktv_domain}/simple/forum.php")
      form = @login_page.form_with(:id=>'lsform')
      form.username = username
      form.password = password
      @page = form.submit
    end
    def activate_user!
      # 必须在login!后立即调用我
      form = @page.form_with(:id=>'registerform')
      @page = form.submit
    end
  end
end

