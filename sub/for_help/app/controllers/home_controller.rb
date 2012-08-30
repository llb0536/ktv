# coding: utf-8
class HomeController < ApplicationController
  before_filter :require_user_text, :only => [:update_in_place,:mute_suggest_item]
  before_filter :require_user, :except => [:newbie,:about,:index,:general_show,:agreement,:mobile,:expert,:elite,:visit]

  def mobile
    render :layout=>false
  end

  def expert
    if current_user
      Visit.create(:page=>"expert",:created_at=>Time.now,:user_id=>current_user.id)
    else
      Visit.create(:page=>"expert",:created_at=>Time.now,:user_id=>nil)
    end
    @render_no_sidebar = true
    arr=["yangshu","wwjarthur","songchuntao","joyzhou","johnding","mr-markl","jimhao","xycareer","zhouxu","davidcon","qiuyeppt","liujun","gudian","zhaoang","lizimian","raydu","xinlinlin","justin-p","zhaomula","mrwang","xiaoqiushui","seca","xuxiaoming","shandandan","beanl","zhedahht","talentpool","allenech","zhaolijuan","kewei0517"]
    @users=[]
    @info={
      "yangshu"=>"甲骨文大中华区求助总监 。毕业于美国加州科技大学，获计算机硕士学位。2002年，加盟知名猎头公司Talent Power，任高级职业顾问。2006年5月，加盟甲骨文，现任甲骨文大中华区求助总监。",
      "jimhao"=>"课件交流系统高级职业顾问。近10年人力资源领域经验。曾参加国家教育部与德国经济技术合作部的长期合作培训项目，在德国学习职业教育，员工培训、个人职业发展及人力资源开发等有关内容，并在德国SAP，ABB，汉莎等多家大型跨国公司从事人事培训部门短期工作。",
      "wwjarthur"=>"德勤中国区求助总监 。18年HR从业经验，服务过制造、电子、快消和专业服务四大行业，从培训助理做到总监，并正向营销和IT云技术应用领域跨界发展。曾任职于欧莱雅、柯达等知名企业。",
      "johnding"=>"简网科技CEO 。1993年毕业于华南理工大学计算机系，在银行工作一年后于1995年开始第一次创业，做了一个软件公司；创业三年后加入微软，历任工程师、顾问、高级顾问、顾问经理、顾问部中国区总监等职位，服务过华为、中国移动、中国电信等不同客户。2004年从微软离开开始第二次创业直至现在，",
      "mr-markl"=>"赶集网高级副总裁 。先后在新加坡丰田、Avanade、微软咨询顾问部工作。2008年7月，加入赶集网，任职技术副总裁，负责赶集网技术研发和管理工作。技术部从不到10人的团队，发展到现在150人的团队。2012年初，罗剑先生晋升为高级副总裁，并开始负责赶集网产品和技术两大核心部门的",
      "zhouxu"=>"银泰百货集团 人力资源部总经理。 15年以上专业人力资源管理经验。近10年全国性大型零售连锁企业人力资源从业经验。先后服务于永乐电器，茂业国际等知名企业。2010年加盟银泰百货集团，任人力资源部总经理。",
      "davidcon"=>"清华大学总裁班特聘讲师 大卫咨询首席顾问。知名管理咨询专家，人民大学MBA，CHRP注册人力资源管理师特聘讲师，《前沿讲座》特聘专家。擅长实施企业管理体系设计、组织发展与员工改善管理等咨询。先后服务于KELLWOOD中国、沃尔玛，担任中高级管理人员。",
      "joyzhou"=>"陆逊梯卡大中国区（亮视点）人力资源副总裁。世界五百强企业从事人力资源及培训工作近15年时间，现任全球最大眼镜企业陆逊梯卡大中华区人力资源副总裁，涵盖亮视点在中国及香港地区零售店铺及办公室的人力资源管理，涵盖求助，培训发展，薪酬福利，员工关系等工作。",
      "songchuntao"=>"民生银行总行高级培训经理。学术表达书《一句顶一句：说着说着就成了》的作者；从事管理培训、人力资本咨询超过10年，先后服务过安利、雅芳、IBM、民生银行等众多国际和本土知名企业；曾为100多家企业、3000多名高级管理层、中基层经理、企业内训师、品牌宣讲师实施过演讲、表达技巧的培训辅",
      "gudian"=>"职业规划师，新精英生涯创始人。全球职业规划师培训师，职业生涯规划领域专家。致力于职业生涯规划，个人成长教育与咨询。著有《拆掉思维里的墙》畅销书。",
      "liujun"=>"上海卓弈企业管理咨询有限公司市场总监，有14年的建筑行业工作经验，曾任职上海市第五建筑有限公司、上海同济建设有限公司等著名建筑公司，从事项目技术、项目管理工作。自2008年转行从事企业管理、教育培训等方面的咨询工作。4年的创业经历使其拥有丰富的职业规划经验。",
      "qiuyeppt"=>"武汉工程大学副教授、上海卓弈管理咨询公司首席讲师，PPT达人，曾出版:《说服力-让你的PPT会说话》系列图书，以及《榨干百度谷歌-搜索广告大赢家》、《写给大学新生的108个忠告》等畅销图书。具有多年教育、职业规划方面的培训经验。",
      "xycareer"=>"向阳生涯 董事长 首席职业规划师多年来始终专注于职业规划的研究、咨询、培训事业，10年专业资历，累积3600多个案咨询经验，100多场职业规划培训经验，学员遍及全国30多个省市。为航天八院、中海集运、河南移动、国网运行、海信电器、英科国际等数十家企事业单位提供专业服务。",
      "beanl"=>"高森明晨开发部总监，人大MBA校友会副秘书长。2002年-2008年在日本从事金融系统研发工作，具备丰富的IT行业经验与专业造诣。后归国创业，并进入中国人民大学攻读MBA学位。曾任软通动力解决方案总监。",
      "zhaoang"=>"全球职业规划师认证的高级职业规划师,职业生涯教练,有多个职业的学术经验和丰富的职业生涯咨询经验。",
      "lizimian"=>"先后毕业于清华大学，美国乔治亚理工学院。曾供职于百事等知名外企，后从事社交网络营销工作。精通项目管理，取得PMP认证。出版畅销书《不懂项目管理，还敢拼学术》《别告诉我你懂ppt》等。",
      "raydu"=>"经验丰富的职业经理人。计算机专业出身，曾任职于国有特大型企业航天系统，从事技术工作相关工作。后加盟泡泡网，成功转行从事人力资源领域，负责构建公司人力资源体系。2009年加盟盛拓传播，任人力资源总经理。",
      "xinlinlin"=>"10年以上人力资源管理工作经验，曾在多家纳斯达克、德、法上市公司担任集团人力资源经理、总监等职位。有丰富的大型多元化集团公司人力资源管理经验，熟悉人力资源各模块，拥有人力资源管理工作的规划、建立、实施和管理经验。",
      "justin-p"=>"资深管理培训师，多年管理及项目经验。具有多个项目成功实施经验，曾参与海尔集团、IBM、北大纵横等多家知名企业人力资源模型构建项目；熟悉战略管理、母子管控、组织架构、流程制度、人力资源、企业文化等管理技能与工具。在业界拥有绝佳的口碑及声誉。",
      "zhaomula"=>"北京市长城企业战略研究所特聘顾问。曾任中关村管委会研究室主任。主持过多个新兴产业发展研究课题和技术创新体系建设战略研究与政策制订。2012年7月，获得“国家高新技术产业开发区建设20年先进个人”。主要代表著作：《中国增长极》等。",
      "mrwang"=>"清华大学中国科学技术政策研究中心资深顾问研究员、中国农业大学MBA导师、曾获得2010年度全球华商百业十大领军人物等多个荣誉称号。著有《硅谷中关村人脉网络》、《知识管理的IT实现》等多部畅销书。",
      "xiaoqiushui"=>"智士软件有限公司高级顾问。拥有9年的金融行业工作经验,和10余年IT行业工作经验。致力于知识管理、时间管理、网络营销、微博营销研究。著有《名博是怎样炼成的》、《超越对手》,现正出版《百问知识管理》和《微博控,控微博》。",
      "seca"=>"和谐生产方式创始人之一,社会化媒体生存实践人。自1998年起,研究各时期的信息化、企业管理相关社区、博客以及微博网站等,撰写相关文章二百余篇。曾参与创建温州市信息管理学会,并任首届秘书长,先后在三家企业任高管。具有丰富的企业管理经验。",
      "xuxiaoming"=>"合肥天地人管理咨询有限公司（筹备）法人代表。东北财经工商管理硕士,历任500强IT公司渠道经理、中国著名装饰公司营销总监、中国知名高新企业总经理、投资公司总经理等职,、并担任多家企业顾问。擅长求助辅导、职业发展、创业分析等。有着丰富的学术经验和资深的专业理论。",
      "shandandan"=>"重庆市木通文化传媒项目发展中心总监。10年以上媒体行业从业经验，《宜昌生活向导》报创始人，拥有丰富的学术经验和创业经验，熟悉ITV媒体产品的全国性拓展推广；CCDM中国职业规划师，在MBTI性格类型、人职匹配、学术困惑等方面有着独特且专业的见解。",
      "zhedahht"=>"《剑指Offer》一书作者。曾任Autodesk软件开发工程师；在微软担任软件设计工程师。2010年9月加入思科任高级软件工程师。多年来从事软件开发工作，对C/C++/C#以及.NET等语言及平台都较为熟悉。对图形图像、CAD、设计模式、项目管理领域有专业经验。",
      "talentpool"=>"曾在索爱、西门子等500强跨国公司有十多年人力资源从业经历。兼有08奥运会特聘面试官；凤凰网凤凰夜校特约职业顾问；首师大、北航等高校毕业生指导教师等多重身份。对各种面试方法、测评工具、求助渠道；HRBP业务伙伴实际应用等方面有丰富的理论知识及实践经验。",
      "allenech"=>"拥有十多年跨国公司HR经验，曾服务于法国施耐德电气公司近十年，担任历任HR主管、HRBP、合资公司人事经理等职，现任美国霍尼韦尔公司HR高级经理。对HR各模块尤其是求助、培训、人员发展、HRBP等方面拥有丰富经验。",
      "zhaolijuan"=>"现任女性专业文化出版公司-悦读纪,内容中心社科部主任、业内资深策划人。有7年的学术工作经验,致力于策划适合都市学术人阅读的图书。已策划出版《瞬间攻心谈判术》、《学术原动力》等学术畅销图书。善长解决学术人在职业生涯中遇到的心理障碍。",
      "kewei0517"=>"北京阅读纪文化有限责任公司销售中心副总经理,曾任上海华聚文化传播有限公司发行部经理,成功运营《九型人格心灵密码学》等畅销书,获当当网颁发的个人“卓越运营奖”。对学术人的各种心理现象有较深研究,擅长从根源解决学术人的消极心理。"
    }
    @name={
      "yangshu"=>"杨姝",
      "jimhao"=>"郝健",
      "wwjarthur"=>"王文佶",
      "johnding"=>"丁钧",
      "mr-markl"=>"罗剑",
      "zhouxu"=>"周旭",
      "davidcon"=>"刘卫刚",
      "joyzhou"=>"周燕",
      "songchuntao"=>"宋春涛",
      "gudian"=>"古典",
      "liujun"=>"刘俊",
      "qiuyeppt"=>"秋叶",
      "xycareer"=>"洪向阳",
      "beanl"=>"李学斌",
      "zhaoang"=>"赵昂",
      "lizimian"=>"李治",
      "raydu"=>"杜宏",
      "xinlinlin"=>"辛琳琳",
      "justin-p"=>"潘晓军",
      "zhaomula"=>"赵慕兰",
      "mrwang"=>"王德禄",
      "xiaoqiushui"=>"萧秋水",
      "seca"=>"王甲佳",
      "xuxiaoming"=>"徐晓明",
      "shandandan"=>"江晓丹",
      "zhedahht"=>"何海涛",
      "talentpool"=>"牛浬杰",
      "allenech"=>"刘晓勇",
      "zhaolijuan"=>"赵丽娟",
      "kewei0517"=>"柯伟"
    }
    arr.each do |a|
      user=User.find_by_slug(a)
      if !user.blank?
        @users<<user
      end
    end
    render :layout=>false
  end
  
  def elite
    if current_user
      Visit.create(:page=>"elite",:created_at=>Time.now,:user_id=>current_user.id)
    else
      Visit.create(:page=>"elite",:created_at=>Time.now,:user_id=>nil)
    end
    @render_no_sidebar = true
    arr=["yichen","pearl","hcxhr","ssq9902","53474187","yy888-999","chenbian","zy448276","pangxing","mike-shine","77164548","luther","zongzi19","okyeshao","lvcj137","fwjuan20","chen-hui","cinca","ying","wanghong2012","bluesnow","weihongbin","46052578","sqeva","83823419","wenaijun","12111359","nashlove","lub1102","41388269","75312141","zengyufa","prz-wang","braveheart","yanllingling","ziyi8108","wgadam","fjzp","lichunyu","fish19891105","597807279","306551790","licj","4f432ecad1212f533d000209","n1014li"]
    @info={
      "yichen"=>"山西同至人商业集团人力资源管理中心求助经理",
      "pearl"=>"宜昌力道起重机械有限公司 采购管理",
      "hcxhr"=>"深圳电子行业混迹者,致力于专业的人力资源",
      "ssq9902"=>"天津市天风汽车内饰件有限公司 人事主管",
      "53474187"=>"郑州市帅旗科贸有限公司 人力资源经理",
      "chenbian"=>"能源/资源型行业HR 经理",
      "yy888-999"=>"港宏宏宇斯巴鲁HR",
      "mike-shine"=>"某集团人力资源法务咨询师、人力资源测评师",
      "zy448276"=>"山西太原同至人人力资源求助经理",
      "77164548"=>"吉林市船营区英豪英语培训学校，人力资源总监HRD",
      "luther"=>"信益陶瓷（蓬莱）有限公司HR",
      "pangxing"=>"深圳太阳帆人事行政主管",
      "fwjuan20"=>"中国万景集团人力资源经理",
      "chen-hui"=>"宁波奥克斯进出口有限公司 工程师",
      "wanghong2012"=>"CCDM中国职业规划师向阳生涯资深职业规划师",
      "4f432ecad1212f533d000209"=>"学而思HR",
      "weihongbin"=>"CCDM中国职业规划师",
      "lvcj137"=>"广东梅兰日兰电气有限公司行政人事主管",
      "83823419"=>"华鼎建筑装饰有限公司HR",
      "12111359"=>"京安工程有限公司HR",
      "zongzi19"=>"好想你枣业股份有限公司HR",
      "wenaijun"=>"天津一汽 人力资源室主任",
      "nashlove"=>"联众公司求助主管",
      "cinca"=>"成都华迈通信技术有限公司HR",
      "bluesnow"=>"NCS中国 HR顾问",
      "lub1102"=>"元信工程设计装饰有限公司HR经理",
      "ying"=>"北京水木天蓬医疗技术有限公司人事经理",
      "46052578"=>"成都人力资源管理有限公司HR",
      "41388269"=>"山西太原同至人人力资源求助经理",
      "okyeshao"=>"深圳京润珍珠销售有限公司求助副经理",
      "sqeva"=>"沿海地产高级人力资源师",
      "75312141"=>"湖北华明集团人力资源主管",
      "prz-wang"=>"成都统一企业食品有限公司HR",
      "zengyufa"=>"成都凌凯软件科技有限公司 HR",
      "braveheart"=>"易贸集团烟台分公司 求助主管",
      "yanllingling"=>"向阳生涯CCDM职业规划导师",
      "ziyi8108"=>"沈阳欢唱娱乐有限公司人事主管",
      "wgadam"=>"某著名证券公司高级经理，《点灯》学术畅销书作者",
      "fish19891105"=>"中网在线控股有限公司HR",
      "597807279"=>"某广告策划公司HR",
      "306551790"=>"成都腾骏贸易有限公司HR",
      "licj"=>"天安骏业人力资源经理",
      "fjzp"=>"中国国际电子商务中心福建代表处，综合事务部副经理",
      "lichunyu"=>"中国国际电子商务中心福建代表处，综合事务部副经理",
      "n1014li"=>"沈阳金网凯腾软件技术有限公司人事经理",
      
    }
    @users=[]
    arr.each do |a|
      user=User.find_by_slug(a)
      if !user.blank?
        @users<<user
      end
    end
    render :layout=>false
  end
  
  def visit
    if params[:user_id].blank? or params[:user_id].to_s=="nil"
      params[:user_id]=nil
    else
      params[:user_id]=BSON::ObjectId(params[:user_id])
    end
    Visit.create(:page=>params[:page],:user_id=>params[:user_id],:created_at=>Time.now)
    render :text => "1"
  end
  
  def under_verification
    @render_no_sidebar = true
    @raw_raw_raw = true
    render 'application/under_verification'
  end
  def frozen_page
    render file:'shared/banished' and return
  end
  def refresh_sugg
    suggest
    render :layout=>false
  end
  
  def refresh_sugg_ex
    @topic = Topic.find_by_name(params[:topic])
    render text:'no such topic' and return unless @topic
    # render text:TopicSuggestExpert.find_by_topic(@topic) and return
    @related_expert_ids = TopicSuggestExpert.find_by_topic(@topic)
    @related_expert_ids -=current_user.followed_topic_ids if user_signed_in?
    @related_expert_ids = @related_expert_ids.random(7)
    render :layout=>false
  end

  def agreement
    render 'agreement.html.erb'
  end
  
  def index
    suggest
    @log_no_gedaan=true
    @per_page = 20
    if '1'==params[:force_mobile]
      if current_user
        redirect_to '/asks?force_mobile=1'
      else
        redirect_to '/mobile/login'
      end
    else
      if current_user.blank?
        redirect_to '/newbie'
      end
    end
    if current_user
      @notifies, @notifications = current_user.unread_notifies
      @logs = []
      if params[:format] == "js"
        render "/logs/index.js"
      elsif '1'==params[:force_mobile]
        render '/logs/index.mobile'
      else
        render "/logs/ajax_index"
      end
    end
  end
  
  def ajax_get_info
    @per_page = 20
    @logs=[]
    user_asks=[]
    user_answers=[]
    user_asks_time={}
    user_answers_time={}
    logs=Log.any_of({:user_id.in => current_user.following_ids},
      {:target_id.in => current_user.followed_ask_ids},
      {:target_parent_id.in => current_user.followed_ask_ids})
    .and(:action.in => ["NEW","NEW_ANSWER_COMMENT","NEW_ASK_COMMENT", "AGREE", "EDIT"], :_type.in => ["AskLog", "AnswerLog", "CommentLog", "UserLog"], :created_at.gt=>3.months.ago)
    .excludes(:user_id => current_user.id).desc('created_at')
    logs.each do |log|
      if log._type=="AskLog" and ["NEW","EDIT"].include?(log.action) and user_asks.include?(log.user_id.to_s+"_"+log.target_id.to_s) and (log.created_at+2.days)>user_asks_time[log.user_id.to_s+"_"+log.target_id.to_s]
      elsif log._type=="AnswerLog" and ["NEW","EDIT"].include?(log.action) and user_answers.include?(log.user_id.to_s+"_"+log.target_id.to_s) and (log.created_at+2.days)>user_answers_time[log.user_id.to_s+"_"+log.target_id.to_s]
      else
        unless "AskLog"==log._type and log.ask and !(log.ask.is_normal?)
          @logs<<log
          if log._type=="AskLog"
            if !user_asks.include?(log.user_id.to_s+"_"+log.target_id.to_s)
              user_asks<<log.user_id.to_s+"_"+log.target_id.to_s
            end
            user_asks_time[log.user_id.to_s+"_"+log.target_id.to_s]=log.created_at
          elsif log._type=="AnswerLog"
            if !user_answers.include?(log.user_id.to_s+"_"+log.target_id.to_s)
              user_answers<<log.user_id.to_s+"_"+log.target_id.to_s
            end
            user_answers_time[log.user_id.to_s+"_"+log.target_id.to_s]=log.created_at
          end
        end
      end
    end
    @logs=@logs.paginate(:page => params[:page], :per_page => @per_page)
    if params[:format] == "js"
      render "/logs/index.js"
    elsif '1'==params[:force_mobile]
      render '/logs/index.mobile'
    else
      render "/home/ajax_info",:layout=>false
    end
  end
  
  def general_show
    render_404 and return unless params[:identifier] and params[:identifier]!=''
    
    #pan>
    # search according to priority
    res = Topic.nondeleted.find_by_name(params[:identifier])
    res ||= Ask.nondeleted.find_by_title(params[:identifier])
    res ||= User.nondeleted.find_by_slug(params[:identifier])
    
    if res.blank? or ((defined? res.deleted) and !res.normal_deleting_status(current_user))
      render_404
    else
      #pan>
      # versatile redirect
      case res.class
      when Topic
        uri="/topics/#{CGI::escape res.name}"
      when Ask
        uri="/asks/#{res.id}"
      when User
        uri="/users/#{CGI::escape res.slug}"
      end
      redirect_to uri
    end
    
  end
  
  def newbie
    suggest
    set_seo_meta('求助广场')
    @already=[]
    @already = current_user.followed_topic_ids if user_signed_in?
    #where(:created_at.gt => 30.days.ago.utc)
    #1. followers_count 100
    #2. asks count 30
    #3. newer newer newer!
    @already_names = @already.collect{|id| if topic=Topic.where(_id:id).first;topic.name;else;nil;end}.compact
    @topics = []
    @topics = TopicCache.not_in(name:@already_names).limit(20).to_a
    @newasks= AskCache.limit(20).collect{|ask_cache| Ask.nondeleted.where(:_id=>ask_cache.ask_id).first}.compact

    if '1'==params[:force_mobile]
      render 'newbie.mobile',layout:'application.mobile'
    else
      render
    end

  end
  
  def timeline
    @per_page = 20
    # @logs = Log.any_in(:user_id => curr)
  end
  
  def followed
    suggest
    @per_page = 20
    @asks = current_user ? current_user.followed_asks.normal : Ask.normal
    # @asks = @asks.includes(:user)#,:last_answer,:last_answer_user,:topics
    @asks = @asks.nondeleted
    .desc(:answered_at,:id)
    .paginate(:page => params[:page], :per_page => @per_page)

    if params[:format] == "js"
      render "/asks/index.js"
    else
      render "index"
    end
  end
  
  def recommended
    suggest
    @per_page = 20
    @asks = current_user ? Ask.normal.any_of({:topics.in => current_user.followed_topic_ids.map{|t| Topic.get_name(t)}}).not_in(:follower_ids => [current_user.id]).and(:answers_count.lt => 1) : Ask.normal
    @asks = @asks.where(:to_user_id=>nil)#.includes(:user)#,:last_answer,:last_answer_user,:topics)
    .exclude_ids(current_user.muted_ask_ids)
    .nondeleted
    .desc(:answers_count,:answered_at)
    .paginate(:page => params[:page], :per_page => @per_page)

    if params[:format] == "js"
      render "/asks/recommended.js"
    end
  end

  # 查看用户不感兴趣的问题
  # def muted
  #   @per_page = 20
  #   @asks = Ask.normal.includes(:user,:last_answer,:last_answer_user,:topics)
  #                 .only_ids(current_user.muted_ask_ids)
  #                 .desc(:answered_at,:id)
  #                 .paginate(:page => params[:page], :per_page => @per_page)
  # 
  #   set_seo_meta("我屏蔽掉的问题")
  # 
  #   if params[:format] == "js"
  #     render "/asks/index.js"
  #   else
  #     render "index"
  #   end
  # end
   
  def update_in_place
    # TODO: Here need to chack permission
    klass, field, id = params[:id].split('__')
    puts params[:id]

    # 验证权限,用户是否有修改制定信息的权限
    case klass
    when "user" then return if current_user.id.to_s != id
    end
    
    params[:value] = simple_format(params[:value].to_s.strip) if params[:did_editor_content_formatted] == "no"

    object = klass.camelize.constantize.find(id)
    update_hash = {field => params[:value]}
    if ["ask","topic"].include?(klass) and current_user
      update_hash[:current_user_id] = current_user.id
    end
    if object.update_attributes(update_hash)
      if 'body'==field and Answer==object.class
        render :text => object.chomp_body
      else
        render :text => object.send(field).to_s
      end
    else
      Rails.logger.info "object.errors.full_messages: #{object.errors.full_messages}"
      render :text => object.errors.full_messages.join("\n"), :status => 422
    end
  end

  # def about
  #   set_seo_meta("关于")
  #   @users = User.any_in(:email => Setting.admin_emails)
  # end

  def mark_all_notifies_as_read
    notifications = current_user.notifications.nondeleted.where(:has_read=>false)
    notifications.each do |notify|
      # Rails.logger.info "mark_notifies_as_read_one\n"
      notify.update_attribute(:has_read, true)
    end
    render :text => "1"
  end


  def mark_notifies_as_read
    if !params[:ids]
      render :text => "0"
    else
      notifications = current_user.notifications.any_in(:_id => params[:ids].split(","))
      notifications.each do |notify|
        # Rails.logger.info "mark_notifies_as_read\n"
        notify.update_attribute(:has_read, true)
      end
      render :text => "1"
    end
  end


  def report
    name = "访客"
    if(!params[:url] or params[:url]=='')
      redirect_to '/'
      return
    end
    if current_user
      name = current_user.name
    end
    unless params[:desc] and params[:desc]!=''
      flash[:error]='不能为空'
      redirect_to params[:url]
      return
    end
    if current_user.already_jubao(params[:url])
      render text:"相同的举报内容已经存在" and return
    end
    ReportSpam.add(params[:url],params[:desc],name,current_user.id)
    flash[:notice] = "举报信息已经提交，谢谢你。"
    redirect_to params[:url]
  end

  def mute_suggest_item
    # UserSuggestItem.mute(current_user.id, params[:type].strip.titleize, params[:id])
    render :text => "1"
  end
  

end
