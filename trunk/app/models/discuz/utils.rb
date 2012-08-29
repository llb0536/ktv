module Discuz
  module Utils
    def self.get_xookie
      proc{
        dz_auth = cookies[Discuz.cookiepre_real+'auth']
        dz_saltkey = cookies[Discuz.cookiepre_real+'saltkey']
        if current_user.nil? and dz_auth.present?
          u = User.authenticate_through_dz_auth!(request,dz_auth,dz_saltkey)
          if u
            u.update_attribute("last_login_at",Time.now)
            u.inc(:login_times,1)
            LoginLog.create(:user_id=>u.id,:login_at=>Time.now,:range=>(Time.now.to_date-u.created_at.to_date).to_i)
            sign_in(u)
          end
        end
      }
    end
  end
end
