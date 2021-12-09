require_relative 'board'
require_relative 'player'

class Game
  attr_accessor :current_player, :first_player, :second_player, :board

  def initialize
    @board = Board.new
    @first_player = Player.new('Tim', '†')
    @second_player = Player.new('Yeremy', '¥')
    @current_player = first_player
  end

  def start_game
    return if first_player.nil? || second_player.nil? || board.nil?

    puts 'The game starts. The first player to have four connected discs either horizontal, vertical or diagonal wins!'
    play_game
  end

  def play_game
    game_over = false
    until game_over || board.full?
      column = current_player.select_column
      board.valid_column?(column) ? play_round(column) : next
      game_over = board.game_over?
      @current_player = swap_current_player
    end
    end_game
  end

  def play_round(column)
    board.update(column, current_player.symbol)
  end

  def end_game
    board.full? ? puts('The Board is full. Therefore the game ended in a tie.') : winner_announcement
  end

  def winner_announcement
    @current_player = swap_current_player
    puts "!!!! #{current_player.name} has won the game. !!!!"
  end

  def swap_current_player
    @current_player == @first_player ? @second_player : @first_player
  end
end
game = Game.new
game.start_game
