class RemoveIds < ActiveRecord::Migration
  def up
    remove_column :songs, :missing_songs_id
    remove_column :songs, :playlists_id
  end

  def down
    add_column :songs, :missing_songs_id, :integer
    add_column :songs, :playlists_id, :integer
  end
end
