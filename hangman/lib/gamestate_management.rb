module GamestateManagement
  require 'json'

  def save_game(board, player)
    content = { board: board.to_h, player: player.to_h }
    #  create save_games directory or check existance
    create_directory
    # create file to save game, json.serialize um objekt abzuspeichern
    save_file = create_save_file(player.name)
    # write the JSON code into the created file
    JSON.dump(content, save_file)
    save_file.close
  end

  def create_directory
    directory_path = 'save_games'
    Dir.mkdir(directory_path) unless File.exist?(directory_path)
  end

  def create_save_file(name)
    puts 'Enter the desired name of your save file: '
    filename = gets.chomp
    unless File.exist?("./save_games/#{filename}_#{name}.json")
      save = File.open("./save_games/#{filename}_#{name}.json",
                       'w')
    end
    save
  end

  def load_game(name)
    # display all saved JSON files
    show_saves(name)
    # select the file that should be laoded
    selected_save = select_save(name)
    # load the saved JSON file
    load_file(selected_save)
  end

  def show_saves(name)
    puts 'Select a save from the following files.'
    saves = Dir.glob("./save_games/*#{name}*")
    pp saves
  end

  def select_save(name)
    puts 'Please enter the name of the json file (the part before the underscore): '
    input = gets.chomp
    "./save_games/#{input}_#{name}.json"
  end

  def load_file(file)
    JSON.parse(File.read(file), symbolize_names: true)
  end
end
