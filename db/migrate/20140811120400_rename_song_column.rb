class RenameSongColumn < ActiveRecord::Migration
  def change
    rename_column :songs, :song, :title
  end
end
