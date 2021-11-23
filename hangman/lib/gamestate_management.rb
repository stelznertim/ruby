module GamestateManagement
  require 'yaml'

  def save_game(name, word, dash_row, gallow, failure_count, used_letters) # parameterübergabe nicht notwendig
    #  create save_games directory or check existance
    directory_path = 'save_games'
    Dir.mkdir(directory_path) unless File.exist?(directory_path)
    # create file to save game, json.serialize um objekt abzuspeichern
    puts 'Enter the desired name of your save file: '
    filename = gets.chomp
    unless File.exist?("./save_games/#{filename}_#{name}.yaml")
      save = File.open("./save_games/#{filename}_#{name}.yaml",
                       'w')
    end
    # write the yaml code into the created file
    YAML.dump([name, word, dash_row, gallow, failure_count, used_letters], save)
    save.close
  end

  def load_game(name)
    # display all saved YAML files
    puts 'Select a save from the following files.'
    saves = Dir.glob("./save_games/*#{name}*")
    pp saves
    # select the file that should be laoded
    puts 'Please enter the name of the yaml file (the part before the underscore): '
    input = gets.chomp
    filename = "./save_games/#{input}_#{name}.yaml"
    # load the saved YAML file
    data_storage = YAML.safe_load(File.read(filename))
    player.load_name(data_storage[0])
    board.word.load_word(data_storage[1], data_storage[2])
    board.gallow.load_gallow(data_storage[3], data_storage[4])
    board.load_used_letters(data_storage[5])
    # json.dig/yaml.dig parameter laden
    # object destructuring
  end
end
