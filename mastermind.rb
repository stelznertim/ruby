#  main function to execute the program and sequence logic for the game
require_relative 'code'
require_relative 'player'

class Mastermind
  attr_accessor :human, :player_two, :secret_code, :guessing_code, :combinationset, :patternset, :combinations

  def initialize
    @human = Player.new
    @player_two = select_player_two
    @secret_code = SecretCode.new
    @guessing_code = Code.new
    @turn = 0
    @colorcombinations = [[0, 1, 2, 3, 4, 5], [0, 1, 2, 3, 4, 5], [0, 1, 2, 3, 4, 5], [0, 1, 2, 3, 4, 5]]
    @combinations = @colorcombinations[0].product(*@colorcombinations[1..-1])
    @combinationset = @colorcombinations[0].product(*@colorcombinations[1..-1])
    @patterncombinations = [%w[black white], %w[black white], %w[black white], %w[black white]]
    @patternset = @patterncombinations[0].product(*@patterncombinations[1..-1])
  end

  def select_player_two
    puts 'Is Player 2 a Computer? Press y => yes, n => no'
    @player_two = gets.chomp == 'y' ? Computer.new(human.role) : Player.new(human.role)
  end

  def start_game()
    human.announce_role
    player_two.announce_role
    if human.role == 'codebreaker'
      puts("#{@human.name}! You got 12 rounds to crack the secret code otherwise you lost. Let the game begin!")
    else
      puts("#{@player_two.name}! You got 12 rounds to crack the secret code otherwise you lost. Let the game begin!")
    end
  end

  def play_round
    guessing_code.set_code
    guessing_code.compare_code(secret_code)
  end

  def new_game?(choice)
    choice == 'y' ? Mastermind.new.play_game : nil
  end

  def result
    puts guessing_code.matching_pattern.count('black') == 4 ? "Congratz you found the right code in turn #{@turn}. It was #{secret_code.code}" : "You Lost."
  end

  def game_vs_human
    start_game
    secret_code.set_code
    until @turn == 12
      play_round
      @turn += 1
      guessing_code.matching_pattern.count('black') == 4 ? break : guessing_code.clear_cache
    end
  end

  def game_vs_computer
    start_game
    player_two.role == 'codemaker' ? computer_codemaking : computer_codebreaking # rolecheck of computer
  end

  def computer_codemaking
    secret_code.set_random_code
    until @turn == 12
      play_round
      @turn += 1
      guessing_code.matching_pattern.count('black') == 4 ? break : guessing_code.clear_cache
    end
  end

  def computer_codebreaking
    secret_code.set_code
    @guess = [0, 0, 1, 1]
    @copied_code = guessing_code.set_code(@guess)
    @copied_matching_pattern = guessing_code.compare_code(secret_code)
    guessing_code.clear_cache
    combinationset.each_with_index do |item, index|
      guessing_code.set_code(item)
      pp guessing_code.code
      guessing_code.compare_code(@copied_code) != @copied_matching_pattern ? remove_from_combinations(index) : guessing_code.clear_cache
    end
    find_next_guess
  end

  def find_next_guess
    combinations.each_with_index do |item, index|
      patternset.each do |pattern_item|
        combinationset.each do |combinationset_item|
          guessing_code.set_code(combinationset_item)
          pp combinationset.length
          puts guessing_code.set_code(combinationset_item)
          @possible_eliminations += 1 unless guessing_code.compare_code(guessing_code.number_to_color(item)) == pattern_item
          guessing_code.clear_cache
        end
        @possible_elim.push(@possible_eliminations)
        guessing_code.clear_cache
      end
      eliminations.push(possible_elim.max)
    end
    @guess = combinations[eliminations.index_of(eliminations.max)]
  end

  def remove_from_combinations(index)
    guessing_code.combinationset.delete_at(index)
    guessing_code.clear_cache
    puts 'I got invoked'
  end

  def play_game
    if @player_two.instance_of?(Computer)
      game_vs_computer
    else
      game_vs_human
    end
    result
    puts 'Do you want to start a new game? Press y => yes, n => no'
    is_new_game = gets.chomp
    new_game?(is_new_game)
  end
end

Mastermind.new.play_game
