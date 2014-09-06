class JoinsController

  def self.add (song_id, playlist_id)
    Join.create(songs_id: song_id, playlists_id: playlist_id)
  end

  def self.order (join_id, playorder)
    record = Join.find_by(id: join_id)
    other_songs = Join.where(playlists_id: record.playlists_id)
    other_songs.each do |song|
      if song.playorder >= record.playorder
        order = song.playorder += 1
        song.update(playorder: order)
      end
    end
    #if you move a song backwards, it will bump everything else up
    record.update(playorder: playorder)
    JoinsController.view(record.playlists_id)
  end

  def self.view(playlist_index)
    Join.where(playlists_id: playlist_index).order('playorder ASC').each do |join|
      song = Song.find_by(id: join.songs_id)
      puts "#{join.playorder}. #{song.bpm} #{song.key} #{song.title} #{song.artist} #{join.id}"
    end
    puts "type order-id-playorder, remove-id, or main menu"
    input = clean_gets.split("-")
    case input[0]
      when "order"
        JoinsController.order(input[1], input[2])
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
