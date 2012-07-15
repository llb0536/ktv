# coding: utf-8
# todo:del log

namespace :integrity do
  task :all=>:environment do
    Util.integrity_all
  end
end


