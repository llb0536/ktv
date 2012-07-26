# -*- encoding : utf-8 -*-
class CoursewaresController < ApplicationController
  before_filter :authenticate_user!, :only => [:new,:create,:edit,:update,:destroy,:thank]
  before_filter :find_item,:only => [:show,:embed,:download,:edit,:update,:destroy,:thank]
  before_filter :authenticate_user_ownership!, :only => [:update,:destroy]

  def mine
    @seo[:title] = '我关注的'
    render "mine#{@subsite}"
  end
  def latest
    @seo[:title] = '最新课件'
    render "latest#{@subsite}"
  end
  def hot
    @seo[:title] = '最热课件'
    render "latest#{@subsite}"
  end
  def videos
    @seo[:title] = '课堂录像'
  end
  def books
    @seo[:title] = '电子书'
  end
  
  def index
    respond_to do |format|
      format.json{
        pagination_get_ready
        @coursewares = Courseware.nondeleted.normal.desc('updated_at')
        @coursewares = @coursewares.where(:user_id=>params[:user_id]) if params[:user_id]
        @coursewares = @coursewares.where(:topic=>params[:topic]) if params[:topic]
        pagination_over(@coursewares.count)
        @coursewares = @coursewares.paginate(:page => @page, :per_page => @per_page)
      }
    end
  end
  def thank
    current_user.inc(:thank_coursewares_count,1)
    @courseware.user.inc(:thanked_coursewares_count,1)
    @courseware.inc(:thanked_count,1)
    current_user.thank_courseware(@courseware)
    render :text => "1"
  end
  def new_youku
    @seo[:title] = '导入视频网站视频'
    @courseware = Courseware.new
  end
  def new_emule
    @seo[:title] = '导入原始下载地址'
  end
  def new_sina
    @seo[:title] = '导入外站资源链接'
  end
  def new
    @seo[:title] = '上传课件'
    @courseware = Courseware.new
    prepare_s3
  end
  def embed
    @courseware.view!
    respond_to do |format|
      format.html
      format.js
    end
  end
  def show
    @seo[:title] = @courseware.title
    render "show"
  end
  def edit
    @seo[:title] = '编辑课件'
    prepare_s3
  end
  def destroy
    @courseware.soft_delete
    redirect_to '/',:notice=>'已成功删除'
  end
  def download
    downurl = ''
    @courseware.inc(:downloads_count,1)
    if @courseware.xunlei_url.present?
      downurl = @courseware.xunlei_url
    else
      resource = "#{@courseware.id}#{@courseware.revision}.zip"
      expires = 2.minutes.since.to_i
      signature = Sndacs::Signature.generate_temporary_url_signature(:bucket => 'ktv-down',:resource => resource,:secret_access_key => Setting.snda_key,:expires_at => expires)
      downurl = "http://storage-huabei-1.sdcloud.cn/ktv-down/#{resource}?SNDAAccessKeyId=#{Setting.snda_id}&Expires=#{expires}&Signature=#{signature}"
# something like
# http://storage-huabei-1.sdcloud.cn/ktv-down/1.zip?SNDAAccessKeyId=7HDL3HVT04F5RF6BRW90BJUXH&Expires=1342108303&Signature=Bwyy2k9lPqrmFB4%2BBpBV8q%2FDnzI%3D
    end
    redirect_to downurl
  end
protected
  def find_item
    @courseware = Courseware.where(:_id => params[:id]).first
    unless @courseware.present?
      render_404
      return false
    end
  end
  def prepare_s3
    @uptime = Time.now.to_i
    policy = {
      'save-key' =>  "/#{current_user.id}/#{@uptime}.pdf",
      expiration: "#{1.hour.since.to_i}",
      bucket: 'ktv-up',
      'allow-file-type' =>  'pdf',
      'content-length-range' =>  '0,199000000',
    }.to_json
    policy = Base64.encode64(policy).split("\n").join('')
    @config = {
      policy: policy,
      signature: Digest::MD5.hexdigest(policy+'&'+'Vv0WpPhlztxkPn7c9F3x3S8zgRE=')
    }    
  end
  def authenticate_user_ownership!
    unless current_user.id==@courseware.user_id or current_user.id==@courseware.uploader_id
      render text:'这不是你的课件.', status: 401
      return false
    end
  end
end
