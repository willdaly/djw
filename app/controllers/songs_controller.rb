class SongsController

  def welcome
    puts "type add, update, search, delete, or exit"
    choice = clean_gets
    case choice
      when "add"
        add()
      when "update"
        update()
      when "search"
        search()
      when "delete"
        delete()
    end
  end

  def add
    puts "add a song"
    puts "enter song"
    song = clean_gets
    puts "enter bpm"
    bpm = clean_gets
    puts "enter key"
    key = clean_gets
    puts "enter artist"
    artist = clean_gets
    puts "enter secondary key, if applicable"
    key2 = clean_gets
    puts "enter bside bpm, if applicable"
    bside = clean_gets
    Song.create(title: song, bpm: bpm, key: key, artist: artist, key2: key2, bside: bside)
    puts "#{song} added to songs"
    welcome()
  end

  def update
    puts "enter name of song to update"
    name = clean_gets
    song = Song.find_by(title: name)
    if song
      puts "#{song.bpm} #{song.key} #{song.artist} #{song.title}"
    else
      puts "hmm...can't find it"
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
    end
  end

  def delete
    puts "type name of song to delete"
    name = clean_gets
    song = Song.find_by(title: name)
    if song
      puts "#{song.bpm} #{song.key} #{song.artist} #{song.title}"
    else
      puts "hmm...can't find it"
    end
    puts "sure you want to delete #{song.title}? y/n"
    choice = clean_gets
    if choice == "y"
      song.destroy
      welcome()
    else
      welcome()
    end
  end

  def search
    puts "type 'bpm', 'key', 'artist', 'song', or 'exit'"
    choice = clean_gets
    case choice
      when "bpm"
        bpm()
      when "key"
        key()
      when "artist"
        artist()
      when "song"
        song()
    end
  end

  def bpm
    puts "enter lowest bpm"
    lowbpm = clean_gets
    puts "enter highest bpm"
    highbpm = clean_gets
    results = Song.where(bpm: lowbpm..highbpm).order('bpm ASC, key ASC')
    # results = Song.where(["bpm >= ?", "#{lowbpm}"]).where(["bpm <= ?", "#{highbpm}"]).order('bpm ASC, key ASC')
    results.each do |song|
      puts "#{song.bpm} #{song.key} #{song.artist} #{song.title}"
    end
    transpose()
  end

  def key
    puts "enter low bpm"
    lowbpm = clean_gets
    puts "enter high bpm"
    highbpm = clean_gets
    puts "enter key"
    key = clean_gets
    results = Song.where(key: key, bpm: lowbpm..highbpm).order('bpm ASC, key ASC')
    results.each do |song|
      puts "#{song.bpm} #{song.key} #{song.artist} #{song.title} #{results.index(song)}"
    end
    transpose()
  end

  def artist
    puts "what artist do you want to find?"
    artist = clean_gets
    results = Song.where(["artist= ?", "#{artist}"]).order('bpm ASC, key ASC')
    results.each do |song|
      puts "#{song.bpm} #{song.key} #{song.artist} #{song.title} #{results.index(song)}"
    end
    transpose()
  end

  def song
    puts "what song do you want to find?"
    song = clean_gets
    results = Song.where(title: song).order('bpm ASC, key ASC')
    if results.exists?
      results.each do |song|
        puts "#{song.bpm} #{song.key} #{song.artist} #{song.title}"
      end
      transpose()
    else
      puts "couldn't find #{song}. do you want to add it to missing? y/n"
      response = clean_gets
      if response == "y"
        puts "enter artist"
        artist = clean_gets
        Missing_Song.create(title: song, artist: artist)
        puts "#{song} by #{artist} added to missing songs"
      else
        welcome()
      end
    end
  end

  def transpose
    puts "transpose? y/n"
    q = clean_gets
    if q == "y"
      puts "enter bpm"
      bpm = clean_gets
      puts "enter key"
      key = clean_gets
      array = []
      i = 0
      if key[-1] == "M"
        array = ["AbM", "AM", "BbM", "BM", "CM", "DM", "EbM", "EM", "FM", "F#M", "GM"]
        i = array.index(key)
      else
        array = ["abm", "am", "bbm", "bm", "cm", "c#m", "dm", "ebm", "em", "fm", "f#m", "gm"]
        i = array.index(key)
      end
      puts "transpose up or down?"
      direction = clean_gets
      if direction == "up"
        i == 11 ? key = array[0] : key = array[i + 1]
        bpm = (bpm.to_i * 1.06).floor()
      else
        i == 0 ? key = array[11] : key = array[i-1]
        bpm = (bpm.to_i/1.06).floor()
      end
      results = Song.where(key: key, bpm: bpm).order('bpm ASC, key ASC')
      results.each do |song|
        puts "#{song.bpm} #{song.key} #{song.artist} #{song.title}"
      end
    else
      welcome()
    end

  end

  private

  def songs
    @songs ||= Song.all
  end

end
