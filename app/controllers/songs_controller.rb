class SongsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :create, :display_global ]

  def home
    @song = Song.new

  end

  def create
    # receive the link

    link = params[:link]

    # understand what app it belongs to
    app = check_user_app(link)
    # check if it is in the DB
    if app = "spotify"
      song = Song.find_by("")
    end
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
end
