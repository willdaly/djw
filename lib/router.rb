class Router

  def self.welcome
    puts "type songs, search, missing, or playlist"
    choice = STDIN.gets.chomp
    case choice
      when "songs"
        SongsController.welcome()
      when "search"
        SongsController.search()
      when "missing"
        MissingSongsController.welcome()
      when "playlist"
        PlaylistsController.welcome()
    end
  end

end
