# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'
require 'rest-client'
require 'base64'

User.destroy_all if Rails.env.development?
Song.destroy_all if Rails.env.development?




def get_spotify_token
  url = "https://accounts.spotify.com/api/token"
  payload = {}
  payload["grant_type"] = "client_credentials"
  # "grant_type=client_credentials"
  headers = {}
  app_credentials = Base64.strict_encode64("#{ENV["CLIENT_ID"]}:#{ENV["CLIENT_SECRET"]}")
  headers["Authorization"] = "Basic #{app_credentials}"
  res = RestClient.post(url, payload, headers)
  data = JSON.parse(res)

  data["access_token"]
end

def call_spotify_api_id(token)

  ids = "6U68kAjrSFBNjsq6oQIMWJ,6uBhi9gBXWjanegOb2Phh0,2P4wRFA7ftewX1JdN3On2K,55n9yjI6qqXh5F2mYvUc2y,1I8tHoNBFTuoJAlh4hfVVE,0Zbbxnx4SGGHoIow4PpISP,5masKPHeAOVNgxdLebIcK7,0L6UCE1Y0KX3MF2AtxlntI,1wdcCXAOwIu8JotxdVRV82,27NV2KxoQ8WuLMqlTDI61F"


  url = "https://api.spotify.com/v1/tracks?ids=#{ids}"
  res = RestClient.get(url, {"Authorization": "Bearer #{token}"})
  data = JSON.parse(res)
  data["tracks"]
end

# returns net_ease song_id
def call_net_ease_api_search(search_query)
  p search_query
  url = "http://musicapi.leanapp.cn/search?keywords=#{search_query}"
  res = RestClient.get(url)
  data = JSON.parse(res)

  data["result"]["songs"][0]["id"]
end

# returns song hash
def call_net_ease_api_id(id)
  url = "http://musicapi.leanapp.cn/music/url?id=#{id}"
  res = RestClient.get(url)
  data = JSON.parse(res)
  data["data"][0]
end


def call_qq_api_search(search_query)
  # p search_query
  url = "https://c.y.qq.com/soso/fcgi-bin/client_search_cp?p=1&n=2&w=#{search_query}&format=json"
  res = RestClient.get(url)
  data = JSON.parse(res)


  data["data"]["song"]

end


# p call_net_ease_api_id(call_net_ease_api_search("Eminem Lose Yourself"))
# call_qq_api_search("Eminem Lose Yourself")




# # Below is actual code
user = User.create!(email: "user@gmail.com", password: "123456")

tracks = call_spotify_api_id(get_spotify_token)

tracks.each do |track|
name = track["name"]
album = track["album"]["name"]
artist = track["artists"][0]["name"]

song = Song.create!(name: name, album: album, artist: artist)
search_query = "#{name} #{artist}".gsub(/[^\x00-\x7F]/, "")

spotify_hash = track
spotify_url = track["external_urls"]["spotify"]
SongDetail.create!(song: song, app: "spotify", url: spotify_url, info_hash: spotify_hash)


net_ease_hash = call_net_ease_api_id(call_net_ease_api_search(search_query))
net_ease_url = net_ease_hash["url"]
SongDetail.create!(song: song, app: "net_ease", url: net_ease_url, info_hash: net_ease_hash)


qq_hash = call_qq_api_search(search_query)
qq_url = qq_hash["list"][1]["songurl"]
SongDetail.create!(song: song, app: "qq", url: qq_url, info_hash: qq_hash)


History.create!(song: song, user: user)

p "Created #{name} by #{artist}"
end

p "Created #{Song.count} songs"
