# coding: utf-8
namespace :clean do
	task :spamuser=>:environment do
    	spamfile = File.expand_path('./auxiliary/spamusers.txt',Rails.root)
      	begin
      		if File.exists?(spamfile)
        		File.open(spamfile) do |f|
          			while(line = f.gets)
            			myslug = line.strip
            			next if '' == myslug
      					user = User.find_by_slug(myslug)
           				next if user.blank?
      					user.asks.each { |x| x.delete }
      					user.answers.each { |x| x.delete }
      					Log.where(:user_id=>user.id).each { |x| x.delete }
           	 			puts myslug
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

