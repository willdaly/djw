class CreatePlaylists < ActiveRecord::Migration

  def change
    create_table :playlists do |t|
      t.string :playlistname
    end
  end

end
