# Run from project root via. `ruby data/import.rb`
require 'csv'
require 'active_record'
require_relative '../app/models/song'
require_relative '../lib/environment'

Environment.environment = "development"
source = "data/Hip_Hop.csv"

CSV.foreach(source, headers: true) do |row|
  artist = row['Artist']
  title = row['Song']
  bpm = row ['BPM']
  key = row['Key']
  key2 = row['Key 2']
  bside = row['b-side bpm']
  Song.create(artist: artist, title: title, bpm: bpm, key: key, key2: key2, bside: bside)
  puts "imported #{title}"
end
