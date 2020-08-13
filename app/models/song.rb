class Song < ApplicationRecord
  # include ApiCall

  has_many :song_details, dependent: :destroy
  has_many :histories, dependent: :destroy

  def generate_msg
    {
      spotify: "#{song_details.find_by(app: "spotify").url}}",
      net_ease: "#{song_details.find_by(app: "net_ease").url}",
      qq: "#{song_details.find_by(app: "qq").url}"
    }
  end
end
