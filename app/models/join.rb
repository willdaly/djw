class Join < ActiveRecord::Base
  has_many :songs
  has_many :playlists
end
