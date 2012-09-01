# coding: UTF-8
class NotesController < ApplicationController
  def index
    @page = params[:n]
    @x = params[:x]
    @y = params[:y]
    @width = params[:width]
    @height = params[:height]
    @body = params[:body]
    @shared = params[:shared]
    @courseware_id = params[:courseware_id]
    
    
    if current_user.user_type==User::FROZEN_USER
      render text:'window.location.href="/frozen_page"'
      return
    end
    
    @note =  Courseware.find(@courseware_id).notes.build
    @note.page = @page
    @note.x = @x
    @note.y = @y
    @note.width = @width
    @note.height = @height
    @note.body = @body
    @note.shared = @shared
    @note.courseware_id = @courseware_id
    @note.user_id = current_user.id
    if @note.save!
      render :text => 'Succeed',:layout => false
    else
      render :text => 'Failed',:layout => false
    end
  end
  
  def show
    @note = Courseware.find(params[:courseware_id]).notes.find(params[:id])
    @user = User.find(@note.user_id).name
    render :json => { :note => @note.to_json(:only => [:title,:body,:shared,:updated_at]) , :username => @user.to_json}
  end
  
  def edit
    @note = Courseware.find(params[:courseware_id]).notes.find(params[:id])
    @note.body = params[:body]
    if @note.save!
      render :text => 'Succeed',:layout => false
    else
      render :text => 'Failed',:layout => false
    end
  end
  
  def destroy
    @cw =Courseware.find(params[:courseware_id])
    @note = @cw.notes.find(params[:id])
    @note.soft_delete
    redirect_to @cw,:notice=>'笔记被成功删除'
  end
  
end
