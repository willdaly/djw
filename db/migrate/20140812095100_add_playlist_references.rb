class AddPlaylistReferences < ActiveRecord::Migration

  def change
    add_reference :playlists, :songs
    add_reference :songs, :playlists
  end
end
