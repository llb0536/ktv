Courseware.all.each{|cw| cw.update_attribute(:is_thin,cw.thin?)}
Courseware.all.each{|cw| cw.update_attribute(:updated_at,cw.created_at)}
Topic.all.each{|item| item.update_attribute(:coursewares_count,Courseware.where(:topic => item.name).count)}
User.all.each{|item| item.update_attribute(:coursewares_count,Courseware.where(:user_id => item.id).count)}