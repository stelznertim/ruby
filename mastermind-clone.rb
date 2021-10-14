#  main function to execute the program and sequence logic for the game
require_relative 'code'
require_relative 'player'

class Mastermind

  attr_accessor :human, :computer, :secret_code, :code

  def initialize
    @human = Player.new('Caspar', 'codebreaker')
    @computer = Player.new('Tim', 'codemaker')
    @code = Code.new
    @secret_code = SecretCode.new
    @turn = 0
  end

  def  start_game()
    human.announce_role
    computer.announce_role
    secret_code.set_code
    puts("#{@human.name}! You got 12 rounds to crack the secret code otherwise you lost. Let the game begin!")
  end

  def play_round()
    code.set_guessing_code
    code.compare_code
  end 

  def new_game?(choice)
    choice == 'y' ? Mastermind.new.play_game : nil
  end

  def play_game()
    start_game
    until code.matching_pattern.count('black') == 4
      play_round 
      @turn += 1
      code.matching_pattern.count('black') == 4 ? break : code.clear_cache
    end 
    puts "Congratz you found the right code in turn #{@turn} It was #{code.secret_code}"
    puts 'Do you want to start a new game? Press y => yes, n => no'
    is_new_game = gets.chomp
    new_game?(is_new_game)
  end

  
end

Mastermind.new.play_game



