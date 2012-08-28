# -*- encoding : utf-8 -*-
module Ktv
  class DiscuzAdmin
    extend Ktv::Helpers::Config
    include Ktv::Helpers::Config
    include Shared::MechanizeParty
    ADMIN_USER = 'psvr'
    ADMIN_PASS = 'jknlff8-pro-17m7755'
    def start_mode(mode)
      @mode = mode
      @base_url = "http://#{@mode}.kejian.tv/simple"
      # 依赖于forum.php显示登陆框框
      @login_page = @agent.get("#{@base_url}/forum.php")
      form = @login_page.form_with(:id=>'lsform')
      if(form)
        form.username = ADMIN_USER
        form.password = ADMIN_PASS
        @page = form.submit
      end
      @login_page = @agent.get("#{@base_url}/admin.php")
      form = @login_page.form_with(:id=>'loginform')
      if form
        form.admin_password = ADMIN_PASS
        @page = form.submit
      end
      binding.pry
    end

    def self.orthodoxize_course_forums!
      Course.all.each do |item|
        @page = @agent.get("#{@base_url}/admin.php?action=forums&operation=edit&anchor=threadtypes")
        form = @page.forms.first
        selectlist = form.field_with(:name=>'fid')
        selectlist.value = item.fid
        @page = form.submit
        form = @page.forms.last
        form['threadtypesnew[status]']='1'
        form['threadtypesnew[required]']='1'
        form['threadtypesnew[listable]']='1'
      end
    end
  end
end

