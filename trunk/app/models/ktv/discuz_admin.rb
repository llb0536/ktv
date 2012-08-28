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
      if @mode.present?
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
    end

    def orthodoxize_course_forums!
      Course.all.each do |item|
        puts url = "#{@base_url}/admin.php?action=forums&operation=edit&fid=#{item.fid}"
        @page = @agent.get(url)
        form = @page.forms.last
        im_in = false
        @page.body.scan(/name="threadtypesnew\[options\]\[delete\]\[\]" value="(\d+)"/).each{|x| form.add_field!('threadtypesnew[options][delete][]',x.first);im_in=true}
        if im_in
          form.submit
          sleep 1
          @page = @agent.get(url)
          form = @page.forms.last
        end
        form['threadtypesnew[status]']='1'
        form['threadtypesnew[required]']='1'
        form['threadtypesnew[listable]']='1'
        form['detailsubmit']='提交'
        item.teachings.each_with_index do |tch,index|
          form.add_field!('newdisplayorder[]',"#{index+1}");form.add_field!('newname[]',tch.teacher);form.add_field!('newicon[]','');form.add_field!('newenable[]','1');form.add_field!('newmoderators[]','')
        end
        form.submit
        sleep 1
      end
    end
  end
end

