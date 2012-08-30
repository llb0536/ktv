# coding: utf-8
#每天0点5分开始执行
namespace :insert do
  task :daily_stat=>:environment do
    DailyStat.insert_daily_stat(Time.now)
  end
end

