class RemoveColumnsFromSongs < ActiveRecord::Migration[6.0]
  def change
    remove_column :songs, :spotify_url, :string
    remove_column :songs, :qq_url, :string
    remove_column :songs, :net_ease_url, :string
  end
end
