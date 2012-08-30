namespace :update do
  task :pic => :environment do
    
     User.all.each do |u| 
       p u.name
       begin
         u.avatar.recreate_versions! unless u.avatar.blank?
       rescue => e
         p e
       end
     end
    
     Topic.all.each{|u| p u.name;u.cover.recreate_versions! unless u.cover.blank?}
  end
end
