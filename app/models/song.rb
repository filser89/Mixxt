class Song < ApplicationRecord
  has_many :song_details
  has_many :histories
end
