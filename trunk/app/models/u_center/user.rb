module UCenter
  module User
    # array('uid'=>$uid)
    def synlogin(request,opts={})
      res = Ktv::JQuery.ajax({
        :url => "#{UCenter.getdef('UC_API')}/index.php",
        :type => 'POST',
        :accept => '*/*',
        'User-Agent' => request.env['HTTP_USER_AGENT'], 
        :data => {
          m: 'user',
          a: 'synlogin',
          inajax: '2',
          release: UCenter.getdef('UC_CLIENT_RELEASE'),
          input: UCenter::Php.uc_api_input2(request,opts),
          appid: UCenter.getdef('UC_APPID'),
        },
        :psvr_response_anyway => true
      })
      puts res
      return res
    end
    # array()
    def synlogout(request,opts={})
      res = Ktv::JQuery.ajax({
        :url => "#{UCenter.getdef('UC_API')}/index.php",
        :type => 'POST',
        :accept => '*/*',
        'User-Agent' => request.env['HTTP_USER_AGENT'], 
        :data => {
          m: 'user',
          a: 'synlogout',
          inajax: '2',
          release: UCenter.getdef('UC_CLIENT_RELEASE'),
          input: UCenter::Php.uc_api_input2(request,opts),
          appid: UCenter.getdef('UC_APPID'),
        },
        :psvr_response_anyway => true
      })
      puts res
      return res
    end
    def register

    end
    def edit

    end
    def login

    end
    def check_email

    end
    def check_username

    end
    def get_user

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