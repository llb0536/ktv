# coding: utf-8
namespace :extract do
  task :data=>:environment do
    File.open(File.join(Rails.root,'auxiliary/au.txt')) do |f|
      puts "Email,提问数,解答数,评论数,赞成数,反对数"
      while line = f.gets
        begin
          u = User.where(email:line.strip).first
          raise "用户#{line.strip}没有找到" if u.blank?
          print u.email
          print ','
          print u.asks.count
          print ','
          print u.answers.count
          print ','
          print u.comments.count
          print ','
          print Answer.where("votes.up"=>u.id).count
          print ','
          print Answer.where("votes.down"=>u.id).count
          print "\n"
        rescue => e
          p e
        end
      end
    end
  end
end

