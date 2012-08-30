class Askbody2Job
  @queue = :redundancy
  def self.perform(params={})
    @ask = Ask.find(params['ask_id'])
    view = ActionView::Base.new('app/views')
    view.extend ApplicationHelper
    view.extend AsksHelper
    view.extend TopicsHelper
    view.extend UsersHelper
    str = view.render(file:'asks/_ask.html',locals:{item:@ask})
    @ask.update_attribute(:body2,str)
  end
end