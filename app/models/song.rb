class Song < ActiveRecord::Base
  has_many :missing_songs
end
