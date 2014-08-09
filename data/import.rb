# Run from project root via. `ruby data/importer.rb`
require 'csv'
require 'active_record'
require_relative '../app/models/song'
require_relative '../lib/environment'

Environment.environment = "development"
source = "data/Hip_Hop.csv"

CSV.foreach(source, headers: true) do |row|
  artist = row['Artist']
  song = row['Song']
  bpm = row ['BPM']
  key = row['Key']
  Song.create(artist: artist, song: song, bpm: bpm, key: key)
  puts "imported #{song}"
end
