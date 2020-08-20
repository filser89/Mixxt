require 'open-uri'
module CreateMethods
  extend ActiveSupport::Concern
  def self.included(base)
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
        reg = /(\Ahttps:\/\/open.spotify.com\/track\/.+(?=\?))|(\Ahttps:\/\/open.spotify.com\/track\/.+\z)/
        url = link.match(reg).to_s

      elsif app == "net_ease"
        # name_reg = /(?<=《).+(?=》)/
        # name = link.match(name_reg).to_s
        # artist_reg = /(?<=分享).+(?=的单曲)/
        # artist = link.match(artist_reg).to_s
        # search_query = "#{name} #{artist}".gsub(/[^\x00-\x7F]/, "")
        # p search_query
        id_reg = /(?<=https:\/\/y.music.163.com\/m\/song\/).+(?=\/)/
        net_ease_id = link.match(id_reg).to_s

        url = "https://y.music.163.com/m/song/#{net_ease_id}"

      elsif app == "qq"
        name_reg = /(?<=《).+(?=》)/
        name = link.match(name_reg).to_s
        artist_reg = /\A.+(?=《)/
        artist = link.match(artist_reg).to_s
        search_query = "#{name} #{artist}".gsub(/[^\x00-\x7F]/, "")
        qq_hash = call_qq_api_search(search_query)
        puts "QQ HASH #{qq_hash}"
        qq_id = qq_hash["songid"]
        url = "http://y.qq.com/#type=song&id=#{qq_id}"
        # p url
      end
      url
    end

    def name_to_s(name)
      reg = /\(feat.+\)/
      name.gsub(reg, "")
    end

    def artists_arr_to_s(artists)
      artists_str = ""
      artists.each do |artist|
        artists_str += "#{artist["name"]}, "
      end
      n = artists_str.size
      artists_str[0..n - 3]
    end

    def generate_search_query(name, artist, album)
      str = "#{name} #{artist.gsub(",","")} #{album == name ? '' : album}".gsub(/[^\x00-\x7F]/, "")
      CGI.escape(str)
    end

    def upload_img(img, song)
      LC.init :application_id => ENV["APPLICATION_ID"],
        :api_key => ENV["API_KEY"],
        :quiet => true
      photo = LC::File.new({
                             :body => IO.read(img),
                             :local_filename => "#{song.id}_cover.jpg",
                             :content_type => "image/jpeg",
      })
      photo.save
      photo.url
    end

    def img_from_url(url)
      img = open('image.png', 'wb') do |file|
        file << open(url).read
      end
      puts "Created image #{img}"
      img
    end

    def create_spotify_song_detail(song, search_query)
      token = get_spotify_token
      return unless token
      spotify_hash = call_spotify_api_search(token, search_query)
      return unless spotify_hash
      spotify_url = spotify_hash["external_urls"]["spotify"]
      SongDetail.create!(song: song, app: "spotify", url: spotify_url, info_hash: spotify_hash)
      p "spotify_url: #{spotify_url}"
    end

    def create_qq_song_detail(song, search_query)
      qq_hash = call_qq_api_search(search_query)
      return unless qq_hash
      qq_url = "http://y.qq.com/#type=song&id=#{qq_hash["songid"]}"
      SongDetail.create!(song: song, app: "qq", url: qq_url, info_hash: qq_hash)
      p "qq_url: #{qq_url}"
    end

    def create_net_ease_song_detail(song, search_query)
      net_ease_hash = call_net_ease_api_search(search_query)
      return unless net_ease_hash
      net_ease_hash
      net_ease_id = net_ease_hash["id"]
      net_ease_url = "https://y.music.163.com/m/song/#{net_ease_id}"
      SongDetail.create!(song: song, app: "net_ease", url: net_ease_url, info_hash: net_ease_hash)
      p "net_ease_url: #{net_ease_url}"

    end

    def asign_cover_image_url_to_song(song)
      song_detail = song.song_details.find_by(app: "spotify")
      return unless song_detail
      spotify_hash = song_detail.info_hash
      p spotify_hash
      song.cover_image_url = upload_img(img_from_url(spotify_hash["album"]["images"][1]["url"]), song)
      song.save
    end
    def create_song_from_spotify_track(track, user)
      name = name_to_s(track["name"])
      album = track["album"]["name"]
      artist = artists_arr_to_s(track["artists"])

      song = Song.create!(name: name, album: album, artist: artist)
      search_query = generate_search_query(name, artist, album)
      p "Creating #{name} by #{artist}"
      spotify_hash = track
      spotify_url = track["external_urls"]["spotify"]
      SongDetail.create!(song: song, app: "spotify", url: spotify_url, info_hash: spotify_hash)
      p "spotify_url: #{spotify_url}"
      asign_cover_image_url_to_song(song)
      create_net_ease_song_detail(song, search_query)
      create_qq_song_detail(song, search_query)
      History.create!(song: song, user: user)

      p "Created #{name} by #{artist}"
      p "================================================="
      song
    end

    def create_song_from_net_ease_track(track, user, net_ease_id)
      puts "WE ARE IN CREATE FROM NET_EASE"
      # name, artist, album
      name = name_to_s(track["name"])
      album = track["album"]["name"]
      artist = artists_arr_to_s(track["artists"])
      # create song
      song = Song.create!(name: name, album: album, artist: artist)
      # search query
      search_query = generate_search_query(name, artist, album)
      p "Creating #{name} by #{artist}"
      # SongDetail net_ease
      net_ease_hash = track
      net_ease_url = "https://y.music.163.com/m/song/#{net_ease_id}"
      SongDetail.create!(song: song, app: "net_ease", url: net_ease_url, info_hash: net_ease_hash)
      p "net_ease_url: #{net_ease_url}"
      create_spotify_song_detail(song, search_query)
      asign_cover_image_url_to_song(song)
      create_qq_song_detail(song, search_query)

      # History
      History.create!(song: song, user: user)

      p "Created #{name} by #{artist}"
      p "================================================="
      song
    end

    def create_song_from_qq_track(track, user)
      name = name_to_s(track["songname"])
      artist = artists_arr_to_s(track["singer"])
      album = track["albumname"]
      song = Song.create!(name: name, album: album, artist: artist)
      search_query = generate_search_query(name, artist, album)
      p search_query
      p "Creating #{name} by #{artist}"

      qq_hash = track
      qq_url = "http://y.qq.com/#type=song&id=#{qq_hash["songid"]}"
      SongDetail.create!(song: song, app: "qq", url: qq_url, info_hash: qq_hash)
      p "qq_url: #{qq_url}"
      create_spotify_song_detail(song, search_query)
      asign_cover_image_url_to_song(song)
      create_net_ease_song_detail(song, search_query)

      History.create!(song: song, user: user)

      p "Created #{name} by #{artist}"
      p "================================================="
      song
    end

    def create_new_song(link, app, user)
      # if Spotify

      if app == "spotify"
        token = get_spotify_token
        reg = /((?<=https:\/\/open.spotify.com\/track\/).+(?=\/)|(?<=https:\/\/open.spotify.com\/track\/).+(?=\?)|(?<=https:\/\/open.spotify.com\/track\/).+\z)/
        # regex to cut out the id
        p link
        # make a query to Spotify fot track obj
        id = link.match(reg).to_s

        track = call_spotify_api_id(token, id)

        create_song_from_spotify_track(track, user)

      elsif app == "net_ease"
        id_reg = /(?<=https:\/\/y.music.163.com\/m\/song\/).+(?=\/)|(?<=https:\/\/y.music.163.com\/m\/song\?id=).+(?=&)/
        net_ease_id = link.match(id_reg).to_s

        # # get the track
        track = call_net_ease_api_search(net_ease_id)
        # p track
        create_song_from_net_ease_track(track, user, net_ease_id)

      elsif app == "qq"
        name_reg = /(?<=《).+(?=》)/
        artist_reg = /\A.+(?=《)/
        name = link.match(name_reg).to_s.gsub(/[^0-9a-zA-Z']+/, " ").gsub("Explicit", "")
        artist = link.match(artist_reg).to_s.gsub(/[^0-9a-zA-Z']+/, " ")
        p "That's what we search for: #{name} #{artist}"
        search_query = CGI.escape("#{name} #{artist}".gsub(/[^\x00-\x7F]/, ""))
        track = call_qq_api_search(search_query)
        create_song_from_qq_track(track, user)
      end
    end

    def update_count(song, user)
      puts "Inside update count"
      history = History.find_by(song: song, user: user)
      if history
        puts "IF TRUE"
        history.share_count += 1
        history.save
      else
        puts "IF FALSE"
        History.create!(song: song, user: user)
      end
    end
  end
end
