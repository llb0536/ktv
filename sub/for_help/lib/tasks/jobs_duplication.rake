# coding: utf-8
# require 'progressbar'
namespace :update do
  task :duplication=>:environment do
    view = ActionView::Base.new('app/views')
    view.extend ApplicationHelper
    view.extend AsksHelper
    view.extend TopicsHelper
    view.extend UsersHelper
    items = Topic.all.to_a
    len = items.count - 1
    0.upto(len) do |i|
      begin
        puts "#{i}/#{len}. #{items[i].name}"
        items[i].save!        
	puts items[i].name
      rescue => e
        p e
      end
    end

=begin
    items = User.all.to_a
    len = items.count - 1
    0.upto(len) do |i|
      begin
        puts "#{i}/#{len}. #{items[i].name}"
        items[i].update_consultant!
	puts items[i].slug
      rescue => e
        p e
      end
    end
    logs = Log.all
    len = logs.count-1
    threads = []
    (0..len).each {|i|
      begin
        puts "#{i}/#{len}. #{logs[i].name}"
        log = logs[-(i+1)]
         # if !log
        log.update_attribute(:body,view.render(file:'logs/_log.html',locals:{log:log}))
      rescue => e
        p e
      end
    }
=end

  end


end


