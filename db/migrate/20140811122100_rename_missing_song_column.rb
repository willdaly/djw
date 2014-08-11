class RenameMissingSongColumn < ActiveRecord::Migration
  def change
    rename_column :missing_songs, :song, :title
  end
end
