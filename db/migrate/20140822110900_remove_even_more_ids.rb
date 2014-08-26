class RemoveEvenMoreIds < ActiveRecord::Migration
  def up
    remove_column :missing_songs, :songs_id
    remove_column :missing_songs, :bside
    remove_column :missing_songs, :key2
    remove_column :missing_songs, :key
    remove_column :missing_songs, :bpm
  end

  def down
    add_column :missing_songs, :songs_id
    add_column :missing_songs, :bside
    add_column :missing_songs, :key2
    add_column :missing_songs, :key
    add_column :missing_songs, :bpm
  end
end
