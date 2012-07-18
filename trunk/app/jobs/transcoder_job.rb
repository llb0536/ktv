class TranscoderJob
  @queue = :transcoding
  
  def self.info2page_size(info)
    info.each_with_index{|x,i|if x=~/page size/i;return info[i];end}
    nil
  end
  def self.f2i(s,t)
    ss = s.split('.')
    tt = t.split('.')
    ss[1]||=''
    tt[1]||=''
    if ss[1].length > tt[1].length
      tt[1] += '0'*(ss[1].length-tt[1].length)
    elsif ss[1].length < tt[1].length
      ss[1] += '0'*(tt[1].length-ss[1].length)
    end
    ["#{ss[0]}#{ss[1]}".to_i,"#{tt[0]}#{tt[1]}".to_i]
  end
  
  def self.perform(id)
    @courseware = Courseware.find(id)
    working_dir = "#{Rails.root}/auxiliary/ftp/cw/#{@courseware.id}"
    pdf_path = "#{working_dir}/#{@courseware.pdf_filename}"
    `mkdir -p "#{working_dir}"`
    if @courseware.remote_filepath
      `curl "#{@courseware.remote_filepath}" > "#{pdf_path}"`
      info = `pdfinfo "#{pdf_path}"`.split("\n")
      if info = info2page_size(info)
        @courseware.pdf_size_note = info
        if info=~/([\d.]+)(\s*)x(\s*)([\d.]+)/
          @courseware.width,@courseware.height = f2i($1.strip,$4.strip)
        end
      end
      pdf = Grim.reap pdf_path
      @courseware.slides_count = pdf.count
      @courseware.status = 2
      @courseware.pdf_slide_processed = 1
      @courseware.save!
      pinpic_final = ''
      pdf.each_with_index do |page,i|
        puts pic = "#{working_dir}/#{@courseware.revision}slide_#{i}.jpg"
        page.save(pic,:width=>@courseware.slide_width)        
        new_object = $snda_ktv_eb.objects.build("#{@courseware.id}/#{@courseware.revision}slide_#{i}.jpg")
        new_object.content = open(pic)
        new_object.save
        if 0==i
          inf = `identify "#{pic}"`
          if inf=~/JPEG (\d+)x(\d+)/
            @courseware.update_attribute(:real_width, $1.to_i)
            @courseware.update_attribute(:real_height, $2.to_i)
          end
          # ---pinpic---
          pinpic = "#{working_dir}/pin.jpg"
          puts `convert "#{pic}" -resize 222x +repage -gravity North "#{pinpic}"`
          inf = `identify "#{pinpic}"`
          if inf=~/JPEG (\d+)x(\d+)/
            pinpic_final = "#{working_dir}/#{@courseware.revision}pin.1.#{$1}.#{$2}.jpg"
            puts `mv "#{pinpic}" "#{pinpic_final}"`
            @courseware.update_attribute(:pinpicname,File.basename(pinpic_final))
          end
        end
        puts pic2 = "#{working_dir}/#{@courseware.revision}thumb_slide_#{i}.jpg"
        puts `convert "#{pic}" -thumbnail '210x>' -crop 210x158+0+0 +repage -gravity North "#{pic2}"`
        @courseware.update_attribute(:pdf_slide_processed,i+2) unless i+2>@courseware.slides_count
      end
      raise Ktv::Shared::ScriptNeedImprovementException if ["#{working_dir}/slide_*.jpg"].blank? 
      #------------------------zipfile
      zipfile="#{working_dir}/#{@courseware.id}#{@courseware.revision}.zip"
      puts `zip -j "#{zipfile}" "#{pdf_path}"`
      new_object = $snda_ktv_down.objects.build("#{@courseware.id}#{@courseware.revision}.zip")
      new_object.content = open(zipfile)
      new_object.save
      @courseware.update_attribute(:down_pdf_size,File.size(zipfile)/1000)
      #--------------------------thumb
      #only puts /thumb_slide_* files upward
      puts `#{Rails.root}/bin/ftpupyun_pic "#{working_dir}" "/cw/#{@courseware.id}/" "#{@courseware.revision}"`
      #------done
      puts `rm -rf "#{working_dir}"`
      @courseware.go_to_normal
    end

  end
end

# Sidekiq.redis{|r| r.flushall}
# 1286.upto(1290){|i|Courseware.find(i).destroy}
