# -*- encoding : utf-8 -*-
class HookerJob
  @queue = :hooker
  def self.perform(klass,id,method,*args,&block)
    sendee = klass.constantize.find(id)
    sendee.send(method,*args,&block)
  end
end
