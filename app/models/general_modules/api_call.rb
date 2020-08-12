module ApiCall
  extend ActiveSupport::Concern
  def self.included base
    base.extend ClassMethods
  end

  module ClassMethods
    def check_user_app(link)
      if /https:\/\/c.y.qq.com/.match?(link)
        app = "qq"
      elsif /https:\/\/y.music.163.com/.match?(link)
        app = "net_ease"
      elsif /https:\/\/open.spotify.com/.match?(link)
        app = "spotify"
      end
      app
    end

    def call_net_ease_api_search(search_query)
      url = "http://musicapi.leanapp.cn/search?keywords=#{search_query}"
      res = RestClient.get(url)
      data = JSON.parse(res)

      data["result"]["songs"][0]["id"]
    end

    def call_qq_api_search(search_query)
      url = "https://c.y.qq.com/soso/fcgi-bin/client_search_cp?p=1&n=2&w=#{search_query}&format=json"
      res = RestClient.get(url)
      data = JSON.parse(res)
      data["data"]["song"]
    end

    def extract_url(link, app)
      if app == "spotify"
        url = link

      elsif app == "net_ease"
        name_reg = /(?<=《).+(?=》)/
        name = link.match(name_reg)
        artist_reg = /(?<=分享).+(?=的单曲)/
        artist = link.match(artist_reg)
        search_query = "#{name} #{artist}".gsub(/[^\x00-\x7F]/, "")
        # p search_query
        net_ease_id = call_net_ease_api_search(search_query)

        url = "https://y.music.163.com/m/song/#{net_ease_id}"

      elsif app == "qq"
        name_reg = /(?<=《).+(?=》)/
        name = link.match(name_reg)
        artist_reg = /\A.+(?=《)/
        artist = link.match(artist_reg)
        search_query = "#{name} #{artist}".gsub(/[^\x00-\x7F]/, "")
        qq_hash = call_qq_api_search(search_query)
        qq_id = qq_hash["list"][0]["songid"]
        url = "http://y.qq.com/#type=song&id=#{qq_id}"
        # p url
      end
      url
    end
  end
end
