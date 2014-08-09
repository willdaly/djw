class CreateSongs < ActiveRecord::Migration

  def change
    create_table :songs do |t|
      t.string :artist
      t.string :song
      t.integer :bpm
      t.string :key
      t.string :key2
      t.string :bside
    end
  end

end
