# -*- encoding : utf-8 -*-
class AccountController < Devise::RegistrationsController
  def edit
    @user = current_user
  end
  def after_inactive_sign_up_path_for(resource)
    welcome_inactive_sign_up_path
  end
  def new
    render text:'Reg Denied' and return
  end
  # POST /resource
  def create
    render text:'Reg Denied' and return
    build_resource
    # 安全覆写™
    resource.during_registration = true
    resource.name_unknown = false
    resource.email_unknown = false

    if resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_in(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end
  
  def update
    # 安全覆写™
    resource.name_unknown = false
    resource.email_unknown = false

    resource.name = params[:user][:name]
    resource.email = params[:user][:email]
    resource.avatar = params[:user][:avatar]
    resource.tagline = params[:user][:tagline]
    resource.location = params[:user][:location]
    resource.website = params[:user][:website]
    resource.bio = params[:user][:bio]
    
    if resource.email_changed?
      email_warning = '一封确认邮件已经发至您的新电子邮箱地址，请点击其中的链接确认才可成功更改邮箱。'
    else
      email_warning = ''
    end    
    if params[:user][:password].present?
      resource.during_registration = true
      resource.password = params[:user][:password]
      resource.password_confirmation = params[:user][:password_confirmation]
      pass_warning='您的密码已经成功修改，请用新密码登陆'
    else
      pass_warning=''
    end
    if resource.save
      flash[:alert] = email_warning if email_warning.present?
      cookies[:spetial] = pass_warning if pass_warning.present?
      redirect_to edit_user_registration_path,:notice => '个人资料修改成功'
    else
      flash[:alert] = '修改失败'
      render 'edit',:layout => "application_for_devise"
    end
  end

  def destroy
    # Todo: 用户自杀功能
    resource.soft_delete
    sign_out_and_redirect("/login")
    set_flash_message :notice, :destroyed
  end
  
  
  def after_inactive_sign_up_path_for(resource)
    welcome_inactive_sign_up_path
  end
  
end
