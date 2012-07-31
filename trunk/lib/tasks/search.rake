namespace :search do
  task :index => :environment do 
    print "Now indexing search to Redis..."
   

  #     print "Now indexing Ask search to Redis..."
  #     Ask.nondeleted.each do |item|
  #       begin
  #         item.redis_search_index_create
  # puts item.title
  #       rescue => e
  # p e
  #       end
  #     end
    print "Now indexing Courseware search to Redis..."
    Courseware.normal.nondeleted.each do |item|
      begin
      	item.redis_search_index_create
	puts item.title
      rescue => e
	p e
      end
    end

    print "Now indexing Topic search to Redis..."
    Topic.nondeleted.each do |item|
      begin
      	item.redis_search_index_create
	puts item.name
      rescue => e
	p e
      end
    end


       print "Now indexing User search to Redis..."
       User.nondeleted.each do |item|
         begin
           item.redis_search_index_create
           puts item.slug
         rescue => e
   p e
         end
       end

    puts "Done."
  end
end
