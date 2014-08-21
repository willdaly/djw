class RemoveMoreIds < ActiveRecord::Migration
  def up
    remove_column :playlists, :songs_id
  end

  def down
    add_column :playlists, :songs_id
  end
end
