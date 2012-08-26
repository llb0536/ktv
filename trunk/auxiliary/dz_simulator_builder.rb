require 'fileutils'
FileUtils.cd('/root/ktv_simulator') do
  PreForumForum.where(:type=>:group).each do |x|
    FileUtils.mkdir(x.displayorder.to_s.rjust(4, '0')+'.'+x.name.split('/').join('|'))
    FileUtils.cd("/root/ktv_simulator/#{x.displayorder.to_s.rjust(4, '0')+'.'+x.name}") do
      PreForumForum.where(:type=>:forum,:fup=>x.id).each do |y|
        FileUtils.mkdir(y.displayorder.to_s.rjust(4, '0')+'.'+y.name.split('/').join('|'))
        FileUtils.cd("/root/ktv_simulator/#{x.displayorder.to_s.rjust(4, '0')+'.'+x.name}/#{y.displayorder.to_s.rjust(4, '0')+'.'+y.name}") do
          PreForumForum.where(:type=>:sub,:fup=>y.id).each do |z|
            FileUtils.mkdir(z.displayorder.to_s.rjust(4, '0')+'.'+z.name.split('/').join('|'))
          end
        end
      end
    end
  end
end
