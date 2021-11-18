require_relative 'computer'
require_relative 'player'
require_relative 'board'
require_relative 'output'
require_relative 'gamestate_management'

class Hangman
  include GamestateManagement
  attr_accessor :board, :computer, :player

  def initialize
    @board = Board.new
    @player = Player.new
  end

  def start_game
    Output.game_start(player.name, board.word.word.length)
    board.show
    play_game
  end

  def load_game?
    Output.load
    load_game(player.name) unless gets.chomp == 'no'
    start_game
  end

  def play_game
    until game_finished?
      save_current_game?
      guess = player.make_guess
      indexes = Computer.compare_word(guess, board.word.word)
      board.update(guess, indexes)
    end
    end_game
  end

  def save_current_game?
    Output.save
    save_game(player.name, board.word.word, board.word.dash_row, board.gallow.gallow, board.gallow.failure_count, board.used_letters) unless gets.chomp == 'no'
  end

  def end_game
    board.word.word_finished? ? Output.winner_announcement(player.name) : Output.loser_announcement(board.word.word)
    # call method from gamestate-management to delete saved file if there is one
  end

  def game_finished?
    board.word.word_finished? || board.gallow.hangman_completed?
  end
end

game = Hangman.new
game.load_game?
