class JoinsController

  def add (song_id, playlist_id)
    Join.create(songs_id: song_id, playlists_id: playlist_id)
  end

  def order (join_id)
    record = Join.find_by(id: join_id)
    puts "enter song play order"
    playorder = clean_gets
    record.update(playorder: playorder)
    PlaylistsController.new().better(record.playlists_id)
  end

end
