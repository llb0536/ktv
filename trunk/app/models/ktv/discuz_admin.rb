# -*- encoding : utf-8 -*-
module Ktv
  class DiscuzAdmin
    extend Ktv::Helpers::Config
    include Ktv::Helpers::Config
    include Shared::MechanizeParty
    ADMIN_USER = 'psvr'
    ADMIN_PASS = 'jknlff8-pro-17m7755'
    def start_mode(mode=nil)
      @mode = mode
      if @mod.present?
        @base_url = "http://#{@mode}.kejian.#{Rails.env.development? ? 'lvh.me' : 'tv' }/simple"
      else
        @base_url = "http://kejian.#{Rails.env.development? ? 'lvh.me' : 'tv' }/simple"
      end
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
        @page = @agent.get("#{@base_url}/admin.php?action=forums&operation=edit&fid=#{item.fid}")
        form = @page.forms.last
        form['threadtypesnew[status]']='1'
        form['threadtypesnew[required]']='1'
        form['threadtypesnew[listable]']='1'
        form['detailsubmit']='提交'
      end
    end
  end
end

