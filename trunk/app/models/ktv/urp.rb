# -*- encoding : utf-8 -*-
require 'open-uri'
module Ktv
  class Spider
    extend Ktv::Helpers::Config
    include Ktv::Helpers::Config
    include Shared::MechanizeParty
    def self.testcnu!
      cnu = Ktv::Spider.new
      cnu.start_mode(:cnu,'1090500165','pmqpmq55')
      cnu.touch_courses_teachings_departments_teachers
      Course.all.each{|x| x.update_attribute(:years,[20122])}
    end
    def self.testustb!
      ustb = Ktv::Spider.new
      ustb.start_mode(:ustb,'','')
      ustb.touch_courses_departments_ustb_college
      ustb.touch_course_department_public_ustb
      Course.all.each{|x| x.update_attribute(:years,[20122])}
    end
    def self.testbuaa!
      buaa = Ktv::Spider.new
      buaa.start_mode(:buaa,'','')
      buaa.touch_course_departments_buaa
      Course.all.each{|x| x.update_attribute(:years,[20122])}
    end

    def start_mode(mode,username,password)
      @mode = mode
      case @mode
      when :cnu
        @base_url = 'http://202.204.208.75'
        @page = @agent.post("#{@base_url}/loginAction.do",{ldap:'auth',zjh:username,mm:password})
      when :ustb
        @base_url = 'http://wiki.ibeike.com/index.php'
        @public_class='北京科技大学公共选修课列表'
        @departments = ['土木与环境工程学院','冶金与生态工程学院','材料科学与工程学院','机械工程学院','计算机与通信工程学院','自动化学院','数理学院','化学与生物工程学院','东凌经济管理学院','文法学院','外国语学院']      
        @lista = ['土木与环境工程学院','冶金与生态工程学院','材料科学与工程学院','机械工程学院','信息工程学院','数理&化生学院','东凌经济管理学院','文法学院','外国语学院','体育部','图书馆信息咨询部','体育部','武装部','团委']
      when :buaa
        @base_url = 'http://jiaohu.buaa.edu.cn/G2S/ShowSystem/CourseList.aspx?OrgID='
        
      end
    end

    def psvr_clean(str)
      str.split(" ").join('').strip
    end
    
   def touch_course_departments_buaa
        for i in 1..42 do  
          data = open("#{@base_url}#{i.to_s}").read
          # actual [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 21, 22, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 37, 38, 39, 40, 42] is not empty
          xmldoc = Nokogiri::XML(data)
          c_type = '学院课程'
          d_name = xmldoc.xpath('//DataSource//CourseBrief//fOrganizationName').text()
          department = Department.find_or_create_by(name:d_name)
          xmldoc.xpath('//DataSource//CourseList').each_with_index do |cl,index|
            c_name = xmldoc.xpath("//DataSource//CourseList[#{index}]//fCourseName").text()
            c_num = xmldoc.xpath("//DataSource//CourseList[#{index}]//fCourseNo").text()
            if !c_name.blank?
                course = Course.find_or_create_by(number:c_num)
                course.ctype = c_type
                course.name = c_name
                course.department = department.name
                course.save(:validate=>false)
                puts course.number + ':' + course.name + ':' +  course.ctype
            end
          end
       end
   end
    # for ustb-ibeike
   def touch_courses_departments_ustb_college
      for i in 0..(@departments.length-2) do
        @page = @agent.get("#{@base_url}/#{@departments[i]}课程设置")
        parser=@page.parser
        parser.css('.wikitable tr').each do |tr|
          tds = tr.css('td')
          next unless tds.count > 0
          department = Department.find_or_create_by(name:@departments[i])
          if i==0 || i==1 || i==2
            c_type = psvr_clean(tds[1].text)
            c_num = psvr_clean(tds[2].text)
            c_name = psvr_clean(tds[3].text)
          else
            c_type = psvr_clean(tds[0].text)
            c_num = psvr_clean(tds[1].text)
            c_name = psvr_clean(tds[2].text)
          end
          if !c_name.blank?
            course = Course.find_or_create_by(number:c_num)
            course.ctype = c_type
            course.name = c_name
            course.department = department.name
            course.save(:validate=>false)
            puts course.number + ':' + course.name + ':' +  course.ctype
          end
        end
      end
    end
    def touch_course_department_public_ustb
      @page = @agent.get("#{@base_url}/#{@public_class}")
      parser=@page.parser
      c_type = '公共选修'
      c_num = 'public'
      parser.css('#bodyContent ul').each_with_index do |ul,index|
        if index >=2 && index<=15
          ul.css('li').each_with_index do |li,li_index|
              c_nums = c_num + '_' + (index-2).to_s + '_' + li_index.to_s
              c_name = psvr_clean(li.text());
              
              department = Department.find_or_create_by(name:@lista[index-2])
              course = Course.find_or_create_by(number:c_nums)
              course.ctype = c_type
              course.name = c_name
              course.department = department.name
              course.save(:validate=>false)      
              puts course.number + ':' + course.name + ':' + course.ctype + ':' + course.department
          end
        end
      end
    end
    # for cnu
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
