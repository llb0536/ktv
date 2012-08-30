# -*- encoding : utf-8 -*-
module Ktv
  class Urp
    extend Ktv::Helpers::Config
    include Ktv::Helpers::Config
    include Shared::MechanizeParty
    def self.test!
      cnu = Ktv::Urp.new
      cnu.start_mode(:cnu,'1090500165','pmqpmq55')
      cnu.touch_courses_teachings_departments_teachers
      Course.all.each{|x| x.update_attribute(:years,[20122])}
    end
    def start_mode(mode,username,password)
      @mode = mode
      case @mode
      when :cnu
        @base_url = 'http://202.204.208.75'
        @page = @agent.post("#{@base_url}/loginAction.do",{ldap:'auth',zjh:username,mm:password})
      end
    end
    def psvr_clean(str)
      str.split(" ").join('').strip
    end
    def touch_courses_teachings_departments_teachers
      @page = @agent.get("#{@base_url}/courseSearchAction.do?temp=1")
      form = @page.forms.first
      multiselectlist = form.field_with(:name=>'showColumn')
      multiselectlist.select_all
      @page = form.submit
      next_paged = true
      while next_paged
        parser=@page.parser
        parser.css('#user tr').each do |tr|
          tds = tr.css('td')
          next unless tds.count > 0
          department = Department.find_or_create_by(name:psvr_clean(tds[0].text))
          course = Course.find_or_create_by(number:psvr_clean(tds[1].text))
          course.name = psvr_clean(tds[2].text)
          course.department = department.name
          teaching = course.teachings.find_or_create_by(teacher:psvr_clean(tds[6].text.gsub('*','')))
          teaching.credit = psvr_clean(tds[4].text).to_f
          teaching.judge = psvr_clean(tds[5].text)
          teaching_klass = teaching.teaching_klasses.find_or_create_by(number: psvr_clean(tds[3].text))
          teaching_klass.weekspan = psvr_clean(tds[7].text)
          teaching_klass.weekday = psvr_clean(tds[8].text)
          teaching_klass.klassnum = psvr_clean(tds[9].text)
          teaching_klass.geo_location = psvr_clean(tds[10].text)
          teaching_klass.geo_building = psvr_clean(tds[11].text)
          teaching_klass.geo_classroom = psvr_clean(tds[12].text)
          teaching_klass.capacity = psvr_clean(tds[13].text)
          teaching_klass.stu_size = psvr_clean(tds[14].text)
          teaching_klass.save(:validate=>false)
          teaching.save(:validate=>false)
          course.save(:validate=>false)
          puts course.name
        end
        next_paged = false
        @page.links.each do |link|
          if "下一页"==link.text
            @page = link.click
            next_paged = true
            break
          end
        end
      end
    end
  end
end
