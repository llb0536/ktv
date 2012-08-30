# coding: utf-8
namespace :ask do
  task :stat=>:environment do
#	askcnt=Ask.nondeleted.where(:answers_count.gt=>2, :created_at.gt=>5.days.ago).count
#	#askcnt=Ask.nodeleted.count()
#	puts askcnt
	Topic.nondeleted.all.each do |x|
		puts x.name
	end
  end
end

