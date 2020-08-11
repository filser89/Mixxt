class CreateSongs < ActiveRecord::Migration[6.0]
  def change
    create_table :songs do |t|
      t.string :name
      t.string :artist
      t.string :album
      t.string :qq_url
      t.string :spotify_url
      t.string :net_ease_url
      t.string :cover_image_url

      t.timestamps
    end
  end
end
