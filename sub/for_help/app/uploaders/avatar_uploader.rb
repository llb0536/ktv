class AvatarUploader < BaseUploader
  def default_url
    "/assets/avatar/#{version_name}.jpg"
  end

  version :small do
    process :resize_and_pad => [23,23,'rgba(255, 255, 255, 0.0)']
  end
  
  version :small38 do
    process :resize_and_pad => [38,38,'rgba(255, 255, 255, 0.0)']
  end
  
  version :mid do
    process :resize_and_pad => [50,50,'rgba(255, 255, 255, 0.0)']
  end
  
  version :normal do
    process :resize_and_pad => [100,100,'rgba(255, 255, 255, 0.0)']
  end
  
end
