class CreateMissingSongs < ActiveRecord::Migration

  def change
    create_table :missing_songs do |t|
      t.string :artist
      t.string :song
      t.integer :bpm
      t.string :key
      t.string :key2
      t.string :bside
    end
    add_reference :missing_songs, :songs
    add_reference :songs, :missing_songs 
  end

end
