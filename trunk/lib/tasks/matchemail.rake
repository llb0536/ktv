# coding: utf-8

@zombies = []

namespace :match do
  task :mail => :environment do
    matchmails = File.expand_path('./auxiliary/matchmail.txt',Rails.root)
    p matchmails
    begin
      if File.exists?(matchmails)
        File.open(matchmails) do |f|
          while(line=f.gets)
            mymail=line.strip
            next if ''==mymail
	    st = Time.new("2011,12,21,15,30,00");
            u = User.where( :email=>mymail, :created_at.gt => st ).first
            next if u.blank?
            puts mymail 
          end
        end
      else
        raise "Please put line by line"
      end
    rescue => e
      puts "Something went wrong:\n"
      puts "#{e}"
raise e
    end
  end
end

