class MissingSongsController

  def welcome
    puts "type list, add, complete, delete, or exit"
    choice = clean_gets
    case choice
    when "list"
        list()
      when "add"
        add()
      when "complete"
        complete()
      when "delete"
        delete()
    end
  end

  def list
    songs.each do |song|
      puts "#{song.artist} #{song.title}"
    end
    puts "complete? y/n"
    response = clean_gets
    if response == "y"
      complete()
    else
      welcome()
    end
  end

  def add
    puts "report a missing song"
    puts "enter title"
    song = clean_gets
    puts "enter artist"
    artist = clean_gets
    created = Missing_Song.create(title: song, artist: artist)
    puts "#{created.title} by #{created.artist} reported missing"
    welcome()
  end

  def complete
    puts "enter title of song to update"
    title = clean_gets
    song = Missing_Song.find_by(title: title)
    if song
      puts "#{song.artist} #{song.title}"
      puts "enter bpm"
      bpm = clean_gets
      puts "enter key"
      key = clean_gets
      puts "enter secondary key, if applicable"
      key2 = clean_gets
      puts "enter bside bpm, if applicable"
      bside = clean_gets
      Song.create(title: song.title, bpm: bpm, key: key, artist: song.artist, key2: key2, bside: bside)
      song.destroy
      puts "#{song.title} by #{song.artist} added to songs and removed from missing songs"
      welcome()
    else
      puts "can't find #{title}. Do you want to add it? y/n"
      response = clean_gets
      if response == "y"
        Song.add()
      else
        welcome()
      end
    end
  end

  def delete()
    puts "type song title to delete"
    title = clean_gets
    song = Missing_Song.find_by(title: title)
    if song
      puts "#{song.artist} #{song.title}"
    else
      puts "can not find #{title}"
    end
    puts "Delete #{song.title}? y/n"
    choice = clean_gets
    if choice == "y"
      song.destroy
      puts "#{title} deleted"
      welcome()
    else
      welcome()
    end
  end

  private

  def songs
    @songs ||= Missing_Song.all
  end

end
