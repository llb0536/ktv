# coding: utf-8
class LogsController < ApplicationController
  before_filter :we_are_inside_qa
  def we_are_inside_qa
    @we_are_inside_qa = true
  end
  def index
    @per_page = 20
    @logs = Log.desc("$natural")
               .paginate(:page => params[:page], :per_page => @per_page)

#.not_in(:action => ["ADD_TOPIC","INVITE_TO_ANSWER"])
  end
end
