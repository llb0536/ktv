module UCenter
  module User
    UCenter.define('UC_USER_CHECK_USERNAME_FAILED', -1);
    UCenter.define('UC_USER_USERNAME_BADWORD', -2);
    UCenter.define('UC_USER_USERNAME_EXISTS', -3);
    UCenter.define('UC_USER_EMAIL_FORMAT_ILLEGAL', -4);
    UCenter.define('UC_USER_EMAIL_ACCESS_ILLEGAL', -5);
    UCenter.define('UC_USER_EMAIL_EXISTS', -6);
    
    # array('uid'=>$uid)
    def synlogin(request,opts={})
      agent = request.nil? ? Setting.special_agent : request.env['HTTP_USER_AGENT']
      res = Ktv::JQuery.ajax({
        :url => "#{UCenter.getdef('UC_API')}/index.php",
        :type => 'POST',
        :accept => '*/*',
        'User-Agent' => agent, 
        :data => {
          m: 'user',
          a: 'synlogin',
          inajax: '2',
          release: UCenter.getdef('UC_CLIENT_RELEASE'),
          input: UCenter::Php.uc_api_input2(agent,opts),
          appid: UCenter.getdef('UC_APPID'),
        },
        :psvr_response_anyway => true
      })
      return res
    end
    # array()
    def synlogout(request,opts={})
      agent = request.nil? ? Setting.special_agent : request.env['HTTP_USER_AGENT']
      res = Ktv::JQuery.ajax({
        :url => "#{UCenter.getdef('UC_API')}/index.php",
        :type => 'POST',
        :accept => '*/*',
        'User-Agent' => agent, 
        :data => {
          m: 'user',
          a: 'synlogout',
          inajax: '2',
          release: UCenter.getdef('UC_CLIENT_RELEASE'),
          input: UCenter::Php.uc_api_input2(agent,opts),
          appid: UCenter.getdef('UC_APPID'),
        },
        :psvr_response_anyway => true
      })
      return res
    end
    def register(request,opts={})
      agent = request.nil? ? Setting.special_agent : request.env['HTTP_USER_AGENT']
      res = Ktv::JQuery.ajax({
        :url => "#{UCenter.getdef('UC_API')}/index.php",
        :type => 'POST',
        :accept => '*/*',
        'User-Agent' => agent, 
        :data => {
          m: 'user',
          a: 'register',
          release: UCenter.getdef('UC_CLIENT_RELEASE'),
          input: UCenter::Php.uc_api_input2(agent,opts),
          appid: UCenter.getdef('UC_APPID'),
        },
        :psvr_response_anyway => true
      })
      return res
    end
    def update(request,opts={})
      agent = request.nil? ? Setting.special_agent : request.env['HTTP_USER_AGENT']
      res = Ktv::JQuery.ajax({
        :url => "#{UCenter.getdef('UC_API')}/index.php",
        :type => 'POST',
        :accept => '*/*',
        'User-Agent' => agent, 
        :data => {
          m: 'user',
          a: 'update',
          release: UCenter.getdef('UC_CLIENT_RELEASE'),
          input: UCenter::Php.uc_api_input2(agent,opts),
          appid: UCenter.getdef('UC_APPID'),
        },
        :psvr_response_anyway => true
      })
      return res
    end
    def edit(request,opts={})
      agent = request.nil? ? Setting.special_agent : request.env['HTTP_USER_AGENT']
      res = Ktv::JQuery.ajax({
        :url => "#{UCenter.getdef('UC_API')}/index.php",
        :type => 'POST',
        :accept => '*/*',
        'User-Agent' => agent, 
        :data => {
          m: 'user',
          a: 'edit',
          release: UCenter.getdef('UC_CLIENT_RELEASE'),
          input: UCenter::Php.uc_api_input2(agent,opts),
          appid: UCenter.getdef('UC_APPID'),
        },
        :psvr_response_anyway => true
      })
      return res
    end
    def login

    end
    def check_email

    end
    def check_username

    end
    # username, isuid
    # ->
    # $status['uid'],$status['username'],$status['email']
    def get_user(request,opts={})
      agent = request.nil? ? Setting.special_agent : request.env['HTTP_USER_AGENT']
      res = Ktv::JQuery.ajax({
        :url => "#{UCenter.getdef('UC_API')}/index.php",
        :type => 'POST',
        :accept => :xml,
        'User-Agent' => agent, 
        :data => {
          m: 'user',
          a: 'get_user',
          inajax: '2',
          release: UCenter.getdef('UC_CLIENT_RELEASE'),
          input: UCenter::Php.uc_api_input2(agent,opts),
          appid: UCenter.getdef('UC_APPID'),
        },
        :psvr_response_anyway => true
      })
      return res
    end
    def getprotected

    end
    def delete

    end
    def deleteavatar

    end
    def addprotected

    end
    def deleteprotected

    end
    def merge

    end
    def merge_remove

    end
    def getcredit

    end
    def uploadavatar

    end
    def rectavatar

    end
    module_function(*instance_methods)
  end
end