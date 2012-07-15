namespace :naughty do
  task :words=>:environment do
    NaughtyWord.delete_all
    File.open(File.join(Rails.root,'auxiliary/naughty_words.txt')) do |f|
      while line=f.gets
        NaughtyWord.find_or_create_by(word:line.strip)
      end
    end
    puts "#{NaughtyWord.where(:deleted=>0).count} words on record."
  end
  task :clean=>:environment do
    NaughtyWord.where(:deleted=>0).where(:level=>2).each do |n|
      if (n.created_at+3.months)<Time.now
        n.update_attribute(:deleted,1)
      end
    end
    puts "#{NaughtyWord.where(:deleted=>0).count} words on record."
  end
end