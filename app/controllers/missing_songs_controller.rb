class MissingSongsController

  def self.welcome
    tp Missing_Song.all
    puts "type report-missing song name, complete-id, delete-id, main menu, or exit"
    input = STDIN.gets.chomp.split("-")
    case input[0]
    when "report"
        MissingSongsController.add(input[1])
      when "complete"
        MissingSongsController.complete(input[1])
      when "delete"
        MissingSongsController.delete(input[1])
      when "main menu"
        Router.welcome()
    end
  end

  def self.add(title)
    puts "enter artist"
    artist = STDIN.gets.chomp
    created = Missing_Song.create(title: title, artist: artist)
    puts "#{created.title} by #{created.artist} reported missing"
    MissingSongsController.welcome()
  end

  def self.complete(id)
    song = Missing_Song.find_by(id: id)
    if Missing_Song.where(id: id).exists?
      puts "#{song.artist} #{song.title}"
      puts "enter bpm"
      bpm = STDIN.gets.chomp
      puts "enter key"
      key = STDIN.gets.chomp
      puts "enter secondary key, if applicable"
      key2 = STDIN.gets.chomp
      puts "enter bside bpm, if applicable"
      bside = STDIN.gets.chomp
      Song.create(title: song.title, bpm: bpm, key: key, artist: song.artist, key2: key2, bside: bside)
      song.destroy
      puts "#{song.title} by #{song.artist} added to songs and removed from missing songs"
      MissingSongsController.welcome()
    else
      puts "can't find #{title}. Do you want to report it missing? y/n"
      response = STDIN.gets.chomp
      if response == "y"
        Song.add()
      else
        MissingSongsController.welcome()
      end
    end
  end

  def self.delete(id)
    song = Missing_Song.find_by(id: id)
    if song
      puts "#{song.artist} #{song.title}"
    else
      puts "can not find it"
      MissingSongsController.welcome()
    end
    puts "Delete #{song.title}? y/n"
    choice = STDIN.gets.chomp
    if choice == "y"
      song.destroy
      MissingSongsController.welcome()
    else
      MissingSongsController.welcome()
    end
  end

  private

  def songs
    @songs ||= Missing_Song.all
  end

end
