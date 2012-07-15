namespace :clean do
  task :duplicate do
    User.all.each do |user|
      users = User.where(email:user.email)
      if users.count>1
        users = users.to_a
      end
    end
  end
end
