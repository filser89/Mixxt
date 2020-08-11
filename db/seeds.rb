# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'
require 'rest-client'

# Song.destroy_all


def get_spotify_token
  url = "https://accounts.spotify.com/api/token"
  payload = "grant_type=client_credentials"
  headers = {}
  headers["Authorization"] = "Basic <base64 encoded client_id:client_secret>"
  RestClient.post(url, payload, headers)
end

def call_spotify_api_id

  ids = ["6U68kAjrSFBNjsq6oQIMWJ"]
  ids.each do |id|

  url = "https://api.spotify.com/v1/tracks/#{id}"
  response = RestClient.get(url, headers: {"Authorization": "Bearer BQD0naueRIHw4Lgsm-J-JGVstI4FrpUmugnj2OZWoZTZJp6KIfGiwAVVkaPjR-R89ZM8y2Wq5lWRNnaUncFsAJ3dgh8ynCvn1GqLQQuFIM4WoFJKu-jBR7rUw2-3hkauH3rwswqdZMdVaWAwg8kb7QYXwJwaJZyAimc"})
  p response
end
end
call_spotify_api_id
