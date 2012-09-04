# -*- encoding : utf-8 -*-
class LogbodyJob
  @queue = :redundancy
  def self.perform(params={})
    @log = Log.find(params['log_id'])
    view = ActionView::Base.new('app/views')
    view.extend ApplicationHelper
    view.extend AsksHelper
    view.extend TopicsHelper
    view.extend UsersHelper
    str = view.render(file:'logs/_log.html',locals:{log:@log,force_raw:true})
    @log.update_attribute(:body,str)
  end
end
