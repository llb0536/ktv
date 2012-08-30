require "uglifier"
require 'sass'
require 'erb'

def asset_path(arg)
  arg
end

def erb_out(content)
  template = ERB.new(content)
  template.result(binding)
end

task :preprecompile do
    
  Dir.glob('/Users/psvr/trunk/quora/app/assets/javascripts/**/*').each do |f|
    begin
      content = File.open(f).read
      content = erb_out(content) if '.erb'==File.extname(f)
      Uglifier.new.compress(content)
      print "."
    rescue=>e
      puts "\n#{f}: #{e}"
    end
  end
  
  Dir.glob('/Users/psvr/trunk/quora/app/assets/stylesheets/**/*').each do |f|
    begin
      content = File.open(f).read
      content = erb_out(content) if '.erb'==File.extname(f)
      Sass.compile(content)
      print "."
    rescue=>e
      puts "\n#{f}: #{e}"
    end
  end
  
end
