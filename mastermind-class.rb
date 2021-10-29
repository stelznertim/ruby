#  main function to execute the program and sequence logic for the game
require_relative 'code'
require_relative 'player'

class Mastermind
  attr_accessor :codebreaker, :codemaker, :combinations, :combinationset, :patternset, :possible_eliminations, :eliminations

  COLORCOMBINATIONS = [%w[blue red yellow green pink violet], %w[blue red yellow green pink violet], %w[blue red yellow green pink violet], %w[blue red yellow green pink violet]].freeze
  WINNING_CODE = %w[black black black black].freeze

  def initialize
    @player_one = Player.new
    @codemaker = nil
    @codebreaker = nil
    @turn = 0
    @computer_guess = [0, 0, 1, 1]
    @combinations = COLORCOMBINATIONS[0].product(*COLORCOMBINATIONS[1..-1])
    @combinationset = COLORCOMBINATIONS[0].product(*COLORCOMBINATIONS[1..-1])
    @patterncombinations = [%w[black white], %w[black white], %w[black white], %w[black white]]
    @patternset = @patterncombinations[0].product(*@patterncombinations[1..-1]).concat(@patterncombinations[0].product(*@patterncombinations[1..-2]).concat(@patterncombinations[0].product(*@patterncombinations[1..-3]).concat(@patterncombinations[0].product(*@patterncombinations[1..-4])))) << []
    @possible_eliminations = 0
    @possible_elim = []
    @eliminations = []
  end

  def assign_game_role
    @player_one.role == 'codebreaker' ? @codebreaker = @player_one : @codemaker = @player_one
    select_enemy_type
  end

  def select_enemy_type
    print 'Do you want to play vs a Computer or another human? Press 1 => Computer and 2 => human: '
    gets.chomp.to_i == 1 ? build_computer_enemy : build_human_enemy
  end

  def build_computer_enemy
    puts 'Your enemy is a Computer.'
    @codemaker.nil? ? @codemaker = Computer.new('codemaker') : @codebreaker = Computer.new('codebreaker')
  end

  def build_human_enemy
    puts 'Your enemy is a Human.'
    @codemaker.nil? ? @codemaker = Player.new('codemaker') : @codebreaker = Player.new('codebreaker')
  end

  def start_game
    codebreaker.announce_role
    codemaker.announce_role
  end

  def result(result)
    puts result == 'win' ? "Congratz you found the right code in turn #{@turn}. It was #{codemaker.code.code}" : "You Lost. It was #{codemaker.code.code}"
  end

  def game_vs_human
    start_game
    puts "#{codemaker.name} please insert your secret code now: "
    secret_code = codemaker.set_code
    puts("#{@codebreaker.name}! You got 12 rounds to crack the secret code otherwise you lost. Let the game start!")
    play_all_rounds(secret_code)
  end

  def game_vs_computer
    start_game
    if codemaker.instance_of?(Computer)
      secret_code = codemaker.set_random_code
      puts("#{@codebreaker.name}! You got 12 rounds to crack the secret code otherwise you lost. Let the game start!")
      result = play_all_rounds(secret_code)
    else
      secret_code = codemaker.set_code
      guess = codebreaker.set_code(@computer_guess)
      while @turn < 12
        matching_pattern = build_matching_pattern(guess, secret_code, [])
        if matching_pattern == WINNING_CODE
          return 'win'
        end
        if combinationset.length == 1
          print 'New Guess:'
          guess = combinationset[0]
          pp guess
        else
          computer_codebreaking(matching_pattern, guess)
          combinations.delete_at(combinations.find_index(guess)) # to avoid using the same guess code twice the last guess will be deleted from the possible guesses
          matching_pattern.clear
          guess.clear
          guess = find_next_guess
          print 'New Guess:'
          pp guess
          @turn += 1
        end
      end
      return 'loss'
    end
    result
  end

  def computer_codebreaking(matching_pattern, guess)
    markers = []
    counter = 0
    combinationset.each_with_index do |item, index| # delete if anstelle von each um mark as removable zu sparen
      combination_pattern = build_matching_pattern(item, guess, [])
      combination_pattern == matching_pattern ? counter += 1 : markers = mark_as_removable(markers, index) # counter + mark_as_removable muss die länge des combinationset ergeben
    end
    markers.sort! { |a, b| b <=> a }
    markers.each do |item|
      combinationset.delete_at(item)
    end
    print 'Combinationset Länge :  '
    pp combinationset.length
    combinationset
  end

  def find_next_guess
    scores = []
    combinations.each_with_index do |guess, guess_index|
      pattern_scores = []
      patternset.each do |pattern|
        possible_elim = 0
        combinationset.each_with_index do |item, index|
          combinations_pattern = build_matching_pattern(item, guess, [])
          possible_elim += 1 unless combinations_pattern == pattern
        end
        pattern_scores << [possible_elim, item_of_combinationset?(guess_index), guess_index]
      end
      pattern_scores.sort!
      scores << pattern_scores[0]
    end
    scores.each do |item|
      item[1] = item[1].zero? ? 2 : 1
    end
    scores.sort!
    highest_score = scores[-1][-1]
    combinations[highest_score]
  end

  def item_of_combinationset?(guess_index)
    combinationset.include?(combinations[guess_index]) ? 0 : 1
  end

  def mark_as_removable(markers, index = nil)
    if !index.nil?
      markers.push(index)
    end
    markers
  end

  def play_all_rounds(secret_code)
    matching_pattern = []
    until @turn == 12
      guess = codebreaker.set_code
      @turn += 1
      print 'Guess: '
      pp guess
      matching_pattern = build_matching_pattern(guess, secret_code, matching_pattern)
      print 'Your matching pattern is: '
      pp matching_pattern
      if matching_pattern == WINNING_CODE
        return 'win'
      end
      matching_pattern.clear
      guess.clear
    end
    'loss'
  end

  def build_matching_pattern(guess, secret_code, pattern)
    guess.uniq.each do |item|
      [guess.count(item), secret_code.count(item)].min.times do
        pattern.push('white')
      end
    end

    4.times do |index|
      if guess[index] == secret_code[index]
        pattern.pop
        pattern.unshift('black')
      end
    end
    pattern
  end

  def play_game
    if @codebreaker.instance_of?(Computer) || @codemaker.instance_of?(Computer)
      result = game_vs_computer
    else
      result = game_vs_human
    end
    result(result)
    puts 'Do you want to start a new game? Press y => yes, n => no'
    is_new_game = gets.chomp
    new_game?(is_new_game)
  end

  def new_game?(choice)
    if choice == 'y' then
      game = Mastermind.new
      game.assign_game_role
      game.play_game
    end
  end
end

game = Mastermind.new
game.assign_game_role
game.play_game
