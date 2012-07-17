# -*- encoding : utf-8 -*-
class CoursewaresController < ApplicationController
  before_filter :authenticate_user!, :only => [:new,:create,:edit,:update,:destroy]
  before_filter :find_item,:only => [:show,:embed,:download,:edit,:update,:destroy]
  def index
    pagination_get_ready
    @coursewares = Courseware.normal.order('updated_at desc')
    pagination_over(@coursewares.count)
    @coursewares = @coursewares.paginate(:page => @page, :per_page => @per_page)
  end
  def new
    @seo[:title] = '上传课件'
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
  def update

  end
  def download
    downurl = ''
    if @courseware.xunlei_url.present?
      downurl = @courseware.xunlei_url
    else
      resource = "#{@courseware.id}.zip"
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
end
