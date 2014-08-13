class RemoveIds < ActiveRecord::Migration
  def down
    remove_column :songs, :missing_songs_id
    remove_column :songs, :playlists_id
  end

end
