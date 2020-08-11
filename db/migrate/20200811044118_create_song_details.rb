class CreateSongDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :song_details do |t|
      t.references :song, null: false, foreign_key: true
      t.string :app
      t.string :url
      t.json :info_hash

      t.timestamps
    end
  end
end
