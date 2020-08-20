class Song < ApplicationRecord
  # include ApiCall

  has_many :song_details, dependent: :destroy
  has_many :histories, dependent: :destroy

  def generate_msg
    msg = {}
    spotify = song_details.find_by(app: "spotify")
    msg[:spotify] = spotify ? spotify.url : "Could not find this song on Spotify."
    net_ease = song_details.find_by(app: "net_ease")
    msg[:net_ease] = net_ease ? net_ease.url : "Could not find this song on NetEase Music"
    qq = song_details.find_by(app: "qq")
    msg[:qq] = qq ? qq.url : "Could not find this song on QQ Music"
    p msg
    msg
  end
end
