     # todo: 垃圾清理 
=begin
      0.upto(cw.slides_count-1) do |i|
        Ktv::Upyun::File.new("cw/#{cw.id}/thumb_slide_#{i}.jpg").delete
      end
      Ktv::Upyun::File.new("cw/#{cw.id}/#{cw.pinpicname}").delete
=end
