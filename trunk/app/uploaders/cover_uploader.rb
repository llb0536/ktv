class CoverUploader < BaseUploader
  def default_url
    "/assets/cover/#{version_name}.jpg"
  end

  version :small do
    process :resize_to_fit => [23, 23]
  end
  
  version :small38 do
    process :resize_to_limit => [38,38]
  end
  
  version :mid do
    process :resize_to_limit => [50,50]
  end
    
  version :normal do
    process :resize_to_limit => [100, 100]
  end
  
end
