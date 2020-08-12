module CreateMethods
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

    def create_song_from_spotify_track(track)
      name = track["name"]
      album = track["album"]["name"]
      artist = track["artists"][0]["name"]
      cover_image_url = track["album"]["images"][1]["url"]

      song = Song.create!(name: name, album: album, artist: artist, cover_image_url: cover_image_url)
      search_query = "#{name} #{artist}".gsub(/[^\x00-\x7F]/, "")
      p "Creating #{name} by #{artist}"

      spotify_hash = track
      spotify_url = track["external_urls"]["spotify"]
      SongDetail.create!(song: song, app: "spotify", url: spotify_url, info_hash: spotify_hash)
      p "spotify_url: #{spotify_url}"

      net_ease_id = call_net_ease_api_search(search_query)
      net_ease_hash = call_net_ease_api_id(net_ease_id)
      net_ease_url = "https://y.music.163.com/m/song/#{net_ease_id}"
      SongDetail.create!(song: song, app: "net_ease", url: net_ease_url, info_hash: net_ease_hash)
      p "net_ease_url: #{net_ease_url}"

      qq_hash = call_qq_api_search(search_query)
      qq_url = "http://y.qq.com/#type=song&id=#{qq_hash["list"][0]["songid"]}"

      SongDetail.create!(song: song, app: "qq", url: qq_url, info_hash: qq_hash)
      p "qq_url: #{qq_url}"

      History.create!(song: song, user: current_user) if user_signed_in?

      p "Created #{name} by #{artist}"
      p "================================================="
    end

    def create_new_song(link, app)
      # if Spotify
      if app == "spotify"
        # regex to cut out the id
        reg = /(?<=https:\/\/open.spotify.com\/track\/).+(?=\?)/
        # make a query to Spotify fot track obj
        id = link.match(reg)

        token = get_spotify_token

        track = call_spotify_api_id(token, id)

        create_song_from_spotify_track(track)


        # get artist and title
        # make queries to NetEase and QQ in order to get their objects
        # create a song with title, artist and album
        # create 3 song_detail instances (song: @song, app: {application}, url and hash_info with respective info)
        # create history (user: current_user, song: @song)
        # make up a msg based on the links (instance method of song)
      end
    end
  end
end
