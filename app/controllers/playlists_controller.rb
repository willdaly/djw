class PlaylistsController

  def welcome
    puts "playlists"
    puts "type list or add"
    choice = clean_gets
    case choice
      when "list"
        list()
      when "add"
        add()
    end
  end

  def list()
    playlists.each do |playlist|
      puts "#{playlist.id} #{playlist.playlistname}"
      puts "type index of playlist to view"
      index = clean_gets
      view(index)
    end
  end

  def view(playlists_id)
    Song.where(playlists_id: playlists_id).each do |song|
      puts "#{song.bpm} #{song.key} #{song.title} #{song.artist}"
    end
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
