# -*- encoding : utf-8 -*-
require 'active_support/all'
Dir['./{pre_,uc_}*.rb'].each do |filename|
  filename = filename[2..-1]
  claname = filename.split('_').collect{|x| x[0]=x[0].upcase;x}.join('')
  File.open(filename,"w") do |f|
    f.puts("class #{claname[0..-4]} < ActiveRecord::Base")
    f.puts("  set_table_name '#{filename[0..-4]}'")
    f.puts("  establish_connection :psvr_ucenter") if filename.starts_with?('uc_')
    f.puts("end")
  end
end
