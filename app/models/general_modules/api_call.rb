module ApiCall
  extend ActiveSupport::Concern
  def self.included base
    base.extend ClassMethods
  end

  module ClassMethods

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
    def get_spotify_token
      url = "https://accounts.spotify.com/api/token"
      payload = {}
      payload["grant_type"] = "client_credentials"
      # "grant_type=client_credentials"
      headers = {}
      app_credentials = Base64.strict_encode64("#{ENV["CLIENT_ID"]}:#{ENV["CLIENT_SECRET"]}")
      headers["Authorization"] = "Basic #{app_credentials}"
      res = RestClient.post(url, payload, headers)
      p "res"
      data = JSON.parse(res)

      data["access_token"]
    end

    def call_spotify_api_id(token, id)
      url = "https://api.spotify.com/v1/tracks/#{id}"
      res = RestClient.get(url, {"Authorization": "Bearer #{token}"})
      data = JSON.parse(res)

    end

    def call_net_ease_api_id(id)
      url = "http://musicapi.leanapp.cn/music/url?id=#{id}"
      res = RestClient.get(url)
      data = JSON.parse(res)
      data["data"][0]
    end

    def call_spotify_api_search(token, search_query)
      url = "https://api.spotify.com/v1/search?q=#{search_query}&type=track"
      res = RestClient.get(url, {"Authorization": "Bearer #{token}"})
      data = JSON.parse(res)
      data["tracks"]["items"][0]
    end
  end
end
