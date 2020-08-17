class SongsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :create, :display_global, :fetch_msg]

  def home
    # @song = Song.new
    # create if params[:link].present?
    @histories = display_history
    @globals = display_global
    @favorites = display_favorites
    # raise
  end

  def fetch_msg
    @song = Song.new
    @msg = create if params[:link].present?
    puts "MESSAGE #{@msg}"
    render json: {msg: @msg}
  end

  def create
    # receive the link
    puts "inside create"
    user = current_user
    puts "PARAMS LINK _______ #{params[:link]}"
    link = params[:link]


    # understand what app it belongs to
    app = Song.check_user_app(link)
    # extract url from link
    url = Song.extract_url(link, app)
    # check if it is in the DB
    song_detail = SongDetail.where("url=? AND app=?", url, app)[0]
    # if YES:
    if link.nil?
      @msg = "Please paste a valid link"
      p "no link pasted"
    elsif song_detail
      @song = Song.find(song_detail.song_id)
      # generate message
      Song.update_count(@song, user)
      p @song
      @msg = @song.generate_msg
      # puts "@msg #{@msg}"
    else
    # if NO:
      p "This song is not in the database"
      @song = Song.create_new_song(link, app, user)
      @msg = @song.generate_msg
      @msg
      # puts "@msg #{@msg}"
    end
    puts "msg #{@msg}"
    @msg
  end
    # check what is app link belongs to
  def share_from_btn
    @user = current_user
    @song = Song.find(params[:song_id])
    p params
    @msg = @song.generate_msg
    render json: {msg: @msg}
  end

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
  # end

  def display_global
    Song.all # add later
  end

  def display_favorites
    @user = current_user if user_signed_in?
    @user.histories.order(:share_count => :desc) if user_signed_in?
  end

  def display_history
    @user = current_user if user_signed_in?
    @user.histories.order(:updated_at => :desc) if user_signed_in?
  end

  private

end
