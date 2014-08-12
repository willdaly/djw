class CreateJoin < ActiveRecord::Migration

  def change
    create_table :joins do |t|
      t.integer :playorder
    end
    add_reference :joins, :songs
    add_reference :joins, :playlists
  end

end
