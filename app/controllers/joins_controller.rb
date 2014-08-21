class JoinsController

  def self.add (song_id, playlist_id)
    Join.create(songs_id: song_id, playlists_id: playlist_id)
  end

  def self.order (join_id)
    record = Join.find_by(id: join_id)
    puts "enter song play order"
    playorder = clean_gets
    record.update(playorder: playorder)
    JoinsController.view(record.playlists_id)
  end

  def self.view(playlist_index)
    songs = []
    Join.where(playlists_id: playlist_index).order('playorder ASC').each do |join|
      songs << Song.find_by(id: join.songs_id)
    end
    #need to add order to table print...but how???
    tp songs
    puts "type order-id, remove-id, or main menu"
    input = clean_gets.split("-")
    case input[0]
      when "order"
        puts "enter join ID of song to reorder"
        join_id = clean_gets
        JoinsController.order(join_id)
      when "remove"
        JoinsController.remove(input[1], playlist_index)
      when "main menu"
        PlaylistsController.welcome()
    end
  end

  def self.remove(songs_id, playlists_id)
    song = Join.find_by(songs_id: songs_id, playlists_id: playlists_id)
    song.destroy
    JoinsController.view(playlists_id)
  end

end
