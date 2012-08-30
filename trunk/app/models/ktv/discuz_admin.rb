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
      puts @base_url
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
        begin
          self.orthodoxize_course item
        rescue=>e
          puts e
        end
      end
    end
    def orthodoxize_course(item)
      puts url = "#{@base_url}/admin.php?action=forums&operation=edit&fid=#{item.fid}"
      @page = @agent.get(url)
      parser = @page.parser
      form = @page.forms.last
      form['threadtypesnew[status]']='1'
      form['threadtypesnew[required]']='1'
      form['threadtypesnew[listable]']='1'
      form['threadtypesnew[prefix]']='1'
      item.teachings.each_with_index do |tch,index|
        if parser.css("input[value='#{tch.teacher}']").present?
          puts "#{tch.teacher} exists."
          next
        end
        form.add_field!('newdisplayorder[]',"#{index+1}");form.add_field!('newname[]',tch.teacher);form.add_field!('newicon[]','');form.add_field!('newenable[]','1');form.add_field!('newmoderators[]','')
      end
      form['detailsubmit']='提交'
      form.submit
    end
  end
end

