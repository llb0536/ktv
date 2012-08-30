# encoding: utf-8

class ShortAdvUploader < BaseUploader
  
  version :normal do
    process :resize_and_pad => [206,70,'rgba(255, 255, 255, 0.0)']
  end

end
