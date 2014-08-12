class PlaylistsController

  def welcome
    puts "playlists"
    puts "type list, add, or main menu"
    choice = clean_gets
    case choice
      when "list"
        list()
      when "add"
        add()
      when "main menu"
        Router.new().welcome()
    end
  end

  def list()
    playlists.each do |playlist|
      puts "#{playlist.id} #{playlist.playlistname}"
    end
    puts "type index of playlist to view"
    index = clean_gets
    view(index)
  end

  def view(playlists_id)
    Song.where(playlists_id: playlists_id).each do |song|
      puts "#{song.bpm} #{song.key} #{song.title} #{song.artist} #{song.id}"
    end
    puts "remove song from playlist? y/n"
    choice = clean_gets
    if choice == "y"
      remove()
    else
      welcome()
    end
  end

  def remove()
    puts "enter id of song to remove"
    id = clean_gets
    song = Song.find_by(id: id)
    song.update(playlists_id: 0)
    puts "#{song.title} removed from playlist"
  end

  def specialist()
    playlists.each do |playlist|
      puts "#{playlist.id} #{playlist.playlistname}"
    end
  end

  def add()
    puts "create playlist"
    puts "enter playlist name"
    name = clean_gets
    created = Playlist.create(playlistname: name)
    puts "#{created.playlistname} created"
    welcome()
  end

  private

  def songs
    @songs ||= Song.all
  end

  def playlists
    @playlists ||= Playlist.all
  end

end
