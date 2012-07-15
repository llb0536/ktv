task :temp_task => :environment do
  File.open("#{Rails.root}/auxiliary/emails_stat.csv","w") do |fw|
    File.open("#{Rails.root}/auxiliary/emails.txt","r") do |fr|
      while(line = fr.gets)        
        puts line
        @from_time = Time.strptime '02/13/2012 00:00',"%m/%d/%Y %H:%M"
        @to_time = Time.strptime '04/06/2012 00:00',"%m/%d/%Y %H:%M"
        user = User.where(email:line.strip).first
        next unless user
        ans = user.answers.where(:created_at.gt=>@from_time).and(:created_at.lt=>@to_time)
        s1 = ans.count
        s2 = ans.inject(0) do |memo,obj|
          memo + obj.up_voters(User).count
        end
        fw.puts("#{user.email},#{s1},#{s2}")
      end
    end
  end
end
