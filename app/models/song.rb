class Song < ApplicationRecord
  has_many :song_details, dependent: :destroy
  has_many :histories
end
