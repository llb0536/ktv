class WinTransJob
  @queue = :transcoding
  def self.perform(remote_url)
    puts "Hello World"
  end
end