class Song < ActiveRecord::Base
  has_many :missing_songs
  belongs_to :playlist
end
