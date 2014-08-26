class SongsController

  def self.welcome
    puts "type add, update, search, delete, main menu, or exit"
    choice = clean_gets
    case choice
      when "add"
        SongsController.add()
      when "update"
        SongsController.update()
      when "search"
        SongsController.search()
      when "delete"
        SongsController.delete()
      when "add to playlist"
        SongsController.add_to_playlist()
      when "main menu"
        Router.welcome()
    end
  end

  def self.submenu()
    puts "type add to playlist;id, transpose;id, search again, or menu"
    input = clean_gets.split(";")
    case input[0]
      when "add to playlist"
        add_to_playlist(input[1])
      when "transpose"
        SongsController.transpose(input[1])
      when "search again"
        SongsController.search()
      when "menu"
        SongsController.welcome()
    end
  end

  def self.add
    puts "enter song title;artist;bpm;key"
    input = clean_gets.split(";")
    puts "enter secondary key, if applicable"
    key2 = clean_gets
    puts "enter bside bpm, if applicable"
    bside = clean_gets
    Song.create(title: input[0], bpm: input[2], key: input[3], artist: input[1], key2: key2, bside: bside)
    puts "#{input[0]} by #{input[1]} added to songs"
    puts "add another song? y/n"
    response = clean_gets
    response == "y" ? add() : SongsController.welcome()
  end

  def self.update
    puts "enter name of song to update"
    name = clean_gets
    song = Song.find_by(title: name)
    if song
      puts "#{song.bpm} #{song.key} #{song.artist} #{song.title}"
    else
      puts "can't find #{name}. search again? y/n"
      answer = clean_gets
      answer == "y" ? update() : SongsController.welcome()
    end
    puts "choose what to update"
    puts "type either bpm, key, artist, or title"
    choice = clean_gets
    case choice
    when "bpm"
      puts "enter bpm"
      bpm = clean_gets
      song.update(bpm: bpm)
    when "key"
      puts "enter key"
      key = clean_gets
      song.update(key: key)
    when "artist"
      puts "enter artist"
      artist = clean_gets
      song.update(artist: artist)
    when "title"
      puts "enter song title"
      title = clean_gets
      song.update(song: title)
    else
      puts "#{choice} isn't a valid choice. try again? y/n"
      response = clean_gets
      response == "y" ? update() : SongsController.welcome()
    end
    puts "update more properties? y/n"
    answer = clean_gets
    answer == "y" ? update() : SongsController.welcome()
  end

  def self.delete
    puts "type name of song to delete"
    name = clean_gets
    song = Song.find_by(title: name)
    if song
      puts "#{song.bpm} #{song.key} #{song.artist} #{song.title}"
    else
      puts "can not find #{name}"
    end
    puts "Delete #{song.title}? y/n"
    choice = clean_gets
    if choice == "y"
      song.destroy
      puts "#{name} deleted"
      SongsController.welcome()
    else
      SongsController.welcome()
    end
  end

  def self.search
    puts "type 'bpm;lowbpm;highbpm', 'key;lowbpm;highbpm;key', 'artist;artistname', 'song;songname', or 'exit'"
    input = clean_gets.split(";")
    case input[0]
      when "bpm"
        SongsController.bpm(input[1], input[2])
      when "key"
        SongsController.key(input[1], input[2], input[3])
      when "artist"
        SongsController.artist(input[1])
      when "song"
        SongsController.song(input[1])
    end
  end

  def self.bpm(lowbpm, highbpm)
    results = Song.where(bpm: lowbpm..highbpm).order('bpm ASC, key ASC')
    tp results
    SongsController.submenu()
  end

  def self.key(lowbpm, highbpm, key)
    length = key.length
    i = length - 1
    ambigkey = key[0...i]
    results = Song.where(key: [key, ambigkey], bpm: lowbpm..highbpm).order('bpm ASC, key ASC')
    tp results
    SongsController.submenu()
  end

  def self.artist(artist)
    results = Song.where(["artist= ?", "#{artist}"]).order('bpm ASC, key ASC')
    tp results
    SongsController.submenu()
  end

  def self.song(song)
    results = Song.where(title: song).order('bpm ASC, key ASC')
    if results.exists?
      tp results
    else
      puts "couldn't find #{song}. do you want to add it to missing? y/n"
      response = clean_gets
      if response == "y"
        puts "enter artist"
        artist = clean_gets
        Missing_Song.create(title: song, artist: artist)
        puts "#{song} by #{artist} added to missing songs"
      else
        SongsController.welcome()
      end
    end
    SongsController.submenu()
  end

def self.transpose(id)
  song = Song.find_by(id: id)
  bpm = song.bpm
  key = song.key
  array = []
  i = 0
  if key[-1] == "M"
    array = ["AbM", "AM", "BbM", "BM", "CM", "C#M", "DM", "EbM", "EM", "FM", "F#M", "GM"]
    i = array.index(key)
  else
    array = ["abm", "am", "bbm", "bm", "cm", "c#m", "dm", "ebm", "em", "fm", "f#m", "gm"]
    i = array.index(key)
  end
    puts "transpose up or down?"
    direction = clean_gets
    lowbpm = 0
    highbpm = 0
  if direction == "up"
    i == 11 ? key = array[0] : key = array[i + 1]
    lowbpm = (bpm.to_i * 1.06).floor()
    highbpm = (bpm.to_i * 1.06).ceil()
  else
    i == 0 ? key = array[11] : key = array[i-1]
    lowbpm = (bpm.to_i/1.06).floor()
    highbpm = (bpm.to_i/1.06).ceil()
  end
  results = Song.where(key: key, bpm: lowbpm..highbpm).order('bpm ASC, key ASC')
  if results.exists?
    tp results
  else
    puts "no results found"
    SongsController.welcome()
  end
  puts "transpose again? y/n"
  response = clean_gets
  if response == "y"
    transpose()
  else
    SongsController.submenu()
  end
end

  def self.add_to_playlist(id)
    tp Playlist.all
    puts "enter playlist id"
    playlistid = clean_gets.to_i
    if Playlist.where(id: playlistid).exists?
      Join.create(songs_id: id, playlists_id: playlistid)
      song = Song.find_by(id: id)
      playlist = Playlist.find_by(id: playlistid)
      puts "#{song.title} added to #{playlist.playlistname}"
      puts "add more? y/n"
      answer = clean_gets
      if answer == "y"
        puts "enter song id"
        songid = clean_gets.to_i
        SongsController.add_to_playlist(songid)
      else
        SongsController.welcome()
      end
    else
      puts "no playlist #{id}. Do you want to make one? y/n"
      response = clean_gets
      if response == "y"
        puts "enter playlist name"
        playlistname = clean_gets
        Playlist.create(playlistname: playlistname)
        puts "#{playlistname} created"
        SongsController.welcome()
      else
        SongsController.welcome()
      end
    end
  end

  private

  def songs
    @songs ||= Song.all
  end

end
