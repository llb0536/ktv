# -*- encoding : utf-8 -*-
require 'rubygems'
require 'zip/zip'
require 'find'
require 'fileutils'

module Ktv
  class Uncompress
    def self.unzip(filename,unzip_dir,remove_after = false)
      Zip::ZipFile.open(filename) do |zip_file|
        zip_file.each do |f|
          f_path=File.join(unzip_dir, f.name)
          FileUtils.mkdir_p("#{Rails.root}/tmp/",File.dirname(f_path))
          zip_file.extract(f, f_path) unless File.exist?(f_path)
        end
      end
      FileUtils.rm(filename) if remove_after
    end
    def self.unzip_get_listunzip(filename)
      
    end
    
    def self.unrar
      
    end
    
    def self.unrar_get_list
      
    end
  end
end