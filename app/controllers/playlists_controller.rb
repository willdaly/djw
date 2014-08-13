class PlaylistsController

  def welcome
    puts "playlists"
    puts "type list, add, delete, or main menu"
    choice = clean_gets
    case choice
      when "list"
        list()
      when "add"
        add()
      when "delete"
        delete()
      when "main menu"
        Router.new().welcome()
    end
  end

  def list()
    tp playlists
    # playlists.each do |playlist|
    #   puts "#{playlist.id} #{playlist.playlistname}"
    # end
    puts "type index of playlist to view"
    index = clean_gets
    # view(index)
    better(index)
  end

  def better(playlist_index)
    Join.where(playlists_id: playlist_index).order('playorder ASC').each do |join|
      song = Song.find_by(id: join.songs_id)
      puts " #{join.playorder}. #{song.title} #{song.bpm} #{song.key} #{song.artist} join ID: #{join.id}"
    end
    puts "change play order? y/n"
    choice = clean_gets
    if choice == "y"
      puts "enter join ID of song to reorder"
      join_id = clean_gets
      JoinsController.new().order(join_id)
    else
      welcome()
    end
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

  def delete()
    playlists.each do |playlist|
      puts "#{playlist.id} #{playlist.playlistname}"
    end
    puts "type id of playlist to delete"
    id = clean_gets
    playlist = Playlist.find_by(id: id)
    name = playlist.playlistname
    puts "are you sure you want to delete #{name}"
    playlist.destroy
    puts "#{name} deleted"
    # welcome()
  end

  private

  def remove()
    puts "enter id of song to remove"
    id = clean_gets
    song = Song.find_by(id: id)
    song.update(playlists_id: 0)
    puts "#{song.title} removed from playlist"
    welcome()
  end

  def songs
    @songs ||= Song.all
  end

  def playlists
    @playlists ||= Playlist.all
  end

end
