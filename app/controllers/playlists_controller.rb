class PlaylistsController

  def self.welcome
    tp Playlist.all
    puts "type view-id, add-playlist name, delete-id, or main menu"
    input = STDIN.gets.chomp.split('-')
    case input[0]
      when "view"
        JoinsController.view(input[1])
      when "add"
        PlaylistsController.add(input[1])
      when "delete"
        PlaylistsController.delete(input[1])
      when "main menu"
        Router.welcome()
    end
  end

  def self.add(name)
    Playlist.create(playlistname: name)
    puts "#{name} created"
    PlaylistsController.welcome()
  end

  def self.delete(id)
    # JoinsController.view(id)
    playlist = Playlist.find_by(id: id)
    puts "are you sure you want to delete #{playlist.playlistname}? y/n"
    choice = STDIN.gets.chomp
    if choice == "y"
      playlist.destroy
      PlaylistsController.welcome()
    else
      PlaylistsController.welcome()
    end
  end

  private

  def songs
    @songs ||= Song.all
  end

  def playlists
    @playlists ||= Playlist.all
  end

end
