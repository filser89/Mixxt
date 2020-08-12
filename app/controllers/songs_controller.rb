class SongsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :create, :display_global ]

  def home
    @song = Song.new

  end

  def create
    # receive the link

    link = params[:link]

    # understand what app it belongs to
    app = check_user_app(link)
    # extract url from link
    url = extract_url(link, app)
    # check if it is in the DB
    song_detail = SongDetail.where("url=? AND app=?", url, app)
    p song_detail
    # if YES:

    # generate message

    # if NO:

    # check what is app link belongs to

    # if Spotify

    # regex to cut out the id
    # make a query to Spotify fot track obj
    # get artist and title
    # make queries to NetEase and QQ in order to get their objects
    # create a song with title, artist and album
    # create 3 song_detail instances (song: @song, app: {application}, url and hash_info with respective info)
    # create history (user: current_user, song: @song)
    # make up a msg based on the links (instance method of song)

    # if Ease Net
    # regex to cut out the title and artist
    # make queries to NetEase, QQ, and Spotify_search in order to get their objects
    # create
    # create a song with title, artist and album
    # create 3 song_detail instances (song: @song, app: {application}, url and hash_info with respective info)
    # create history (user: current_user, song: @song)
    # make up a msg based on the links (instance method of song)

    # if QQ

    # regex to cut out the title and artist
    # make queries to NetEase, QQ, and Spotify_search in order to get their objects
    # create
    # create a song with title, artist and album
    # create 3 song_detail instances (song: @song, app: {application}, url and hash_info with respective info)
    # create history (user: current_user, song: @song)
    # make up a msg based on the links (instance method of song)

    # else "Sorry we can't convert your link as doesn't belong to one of the applications we support"
  end

  def display_global

  end

  def display_favorites

  end

  def display_history

  end

  private

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
  # p search_query
    url = "http://musicapi.leanapp.cn/search?keywords=#{search_query}"
    res = RestClient.get(url)
    data = JSON.parse(res)

    data["result"]["songs"][0]["id"]
  end

  def extract_url(link, app)
    if app == "spotify"
      url = link
    elsif app == "qq"
      name = /(?<=《).+(?=》)/
      artist = /(?<=分享).+(?=的单曲)/
      search_query = "#{name} #{artist}".gsub(/[^\x00-\x7F]/, "")
      net_ease_id = call_net_ease_api_search(search_query)
      url = "https://y.music.163.com/m/song/#{net_ease_id}"
    elsif app == "net_ease"
      name = /(?<=《).+(?=》)/
      artist = /(?<=分享).+(?=的单曲)/
      search_query = "#{name} #{artist}".gsub(/[^\x00-\x7F]/, "")
      net_ease_id = call_net_ease_api_search(search_query)
      url = "https://y.music.163.com/m/song/#{net_ease_id}"
    end
    url
  end
end
