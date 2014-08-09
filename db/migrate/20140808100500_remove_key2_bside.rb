class CreateSongs < ActiveRecord::Migration

  def change
    remove_column :key2, :bside, :string
  end

end
