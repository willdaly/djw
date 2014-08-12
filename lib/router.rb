class Router

  def welcome
    puts "type songs, missing, or playlist"
    choice = clean_gets
    case choice
      when "songs"
        songs_controller = SongsController.new()
        songs_controller.welcome
      when "missing"
        missing_songs_controller = MissingSongsController.new()
        missing_songs_controller.welcome()
      when "playlist"
        playlists_controller = PlaylistsController.new()
        playlists_controller.welcome()
    end
  end

end
