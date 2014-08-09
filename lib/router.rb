class Router
  def self.navigate_songs_menu(songs_controller)
    puts "menu options are list"
    command = clean_gets
    case command
    when "list"
      songs_controller.list
    else
      puts "you gotta type 'list'"  
    end
  end
end
