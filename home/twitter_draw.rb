require 'open-uri'
class Twitter_Draw
  include Twitter
  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
  def initialize()
    @config = {
      consumer_key:"ZlG5QlQT79Gb1R8Qs2KFlQ",
      consumer_secret:"TKAHaUVoDHw6K3IOsn50A2lOzESv0csi3Pa05wcXrw"
    }
    @client = Twitter::REST::Client.new(@config)
    @text = "島根"
    @timer = 1
  end

  def save_file(url)
    filename = File.basename(url)
    open(filename, 'wb') do |file|
      open(url) do |data|
        file.write(data.read)
      end
    end
  end

  def tweet_text_get(get_num)
    a = Array.new
    @client.search("#{@text}",:result_type => "recent").take(get_num).each do |tweet|
      a << tweet.text
    end
    a
  end

  

end
