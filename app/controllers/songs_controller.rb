class SongsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :create, :display_global, :fetch_msg]

  def home
    @histories = display_history
    @globals = display_global
    @favorites = display_favorites
  end

  def fetch_msg
    @song = Song.new
    @msg = create if params[:link].present?
    puts "MESSAGE #{@msg}"
    render json: {msg: @msg}
  end

  def create
    puts "inside create"
    user = current_user
    puts "PARAMS LINK _______ #{params[:link]}"
    link = params[:link]

    app = Song.check_user_app(link)
    url = Song.extract_url(link, app)
    song_detail = SongDetail.where("url=? AND app=?", url, app)[0]
    if song_detail
      @song = Song.find(song_detail.song_id)
      Song.update_count(@song, user)
      p @song
      @msg = @song.generate_msg
    else
    # if NO:
      p "This song is not in the database"
      @song = Song.create_new_song(link, app, user)
      @msg = @song.generate_msg
      @msg
    end
    puts "msg #{@msg}"
    @msg

  end

  def display_global
    Song.all # add later
  end

  def display_favorites
    @user = current_user if user_signed_in?
    @user.histories.order(:share_count => :desc) if user_signed_in?
  end

  def display_history
    @user = current_user if user_signed_in?
    @songs = @user.songs if user_signed_in?
  end

  private

end
