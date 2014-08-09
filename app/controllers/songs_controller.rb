class SongsController

  def welcome
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
    puts "what bpm do you want to find?"
    bpm = clean_gets
    results = Song.find_by_sql("SELECT * FROM songs WHERE bpm = #{bpm}")
    results.each do |song|
      puts "#{song.bpm} #{song.key} #{song.artist} #{song.song}"
    end
    puts "transpose? y/n"
    q = clean_gets
    if q == "y"
      transpose()
    else
      welcome()
    end
  end

  def key
    puts "enter bpm"
    bpm = clean_gets
    puts "enter key"
    key = clean_gets
    results = Song.where(key: key, bpm: bpm)
    results.each do |song|
      puts "#{song.bpm} #{song.key} #{song.artist} #{song.song}"
    end
    puts "transpose? y/n"
    q = clean_gets
    if q == "y"
      transpose()
    else
      welcome()
    end
  end

  def artist
    puts "what artist do you want to find?"
    artist = clean_gets
    results = Song.where(artist: artist)
    results.each do |song|
      puts "#{song.bpm} #{song.key} #{song.artist} #{song.song}"
    end
    puts "transpose? y/n"
    q = clean_gets
    if q == "y"
      transpose()
    else
      welcome()
    end
  end

  def song
    puts "what song do you want to find?"
    song = clean_gets
    results = Song.where(song: song)
    results.each do |song|
      puts "#{song.bpm} #{song.key} #{song.artist} #{song.song}"
    end
    puts "transpose? y/n"
    q = clean_gets
    if q == "y"
      transpose()
    else
      welcome()
    end
  end

  def transpose
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
      key = array[i + 1]
      bpm = (bpm * 1.06).floor()
    else
      key = array[i-1]
      bpm = (bpm.to_i/1.06).floor()
    end
    results = Song.where(key: key, bpm: bpm)
    results.each do |song|
      puts "#{song.bpm} #{song.key} #{song.artist} #{song.song}"
    end
  end

  private

  def songs
    @songs ||= Song.all
  end

end
