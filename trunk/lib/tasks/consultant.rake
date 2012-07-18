namespace :consultant do
  task :index => :environment do 
    print "Now indexing consultant to Redis...\n"
   
    [User,Topic].each do |klass|
      puts "Now indexing #{klass} consultant to Redis..."
      klass.nondeleted.each do |item|
        begin
        	item.update_consultant!
        	puts item.title
        rescue => e
        	p e
        end
      end
    end
    puts "Done."
    
    
  end
end
