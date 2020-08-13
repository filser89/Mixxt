class SongsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :create, :display_global ]

  def home
    @song = Song.new
    display_history
  end

  def create
    # receive the link

    link = params[:link]

    # understand what app it belongs to
    app = Song.check_user_app(link)
    # extract url from link
    url = Song.extract_url(link, app)
    # check if it is in the DB
    song_detail = SongDetail.where("url=? AND app=?", url, app)[0]
    # if YES:
    if song_detail
      song = Song.find(song_detail.song_id)
      # generate message
      @msg = song.generate_msg
      p @msg
    else
    # if NO:
      p "This song is not in the database"
      song = Song.create_new_song(link, app, current_user)
      @msg = song.generate_msg
      p msg
    end


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
    @songs = Song.all
  end

  def display_favorites

  end

  def display_history
    @user = User.first
    @songs = @user.songs
  end

  private

  end
