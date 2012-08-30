# coding: utf-8
class HookerSuspendedJob
  @queue = :hooker_suspended
  def self.perform(klass,id,method,*args,&block)
    sendee = klass.constantize.find(id)
    sendee.send(method,*args,&block)
  end
end