class ThankedUserIds < Mongoid::Migration
  def self.up
    Courseware.all.each{|item| item.update_attribute(:thanked_user_ids,User.where(:thanked_courseware_ids=>item.id).collect(&:id))}
  end

  def self.down
  end
end