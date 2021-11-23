require_relative 'player'
require_relative 'board'
require_relative 'output'
require_relative 'gamestate_management'

class Hangman
  extend GamestateManagement
  attr_accessor :board, :player

  def initialize(args)
    @board = Board.new(args[:board])
    @player = Player.new(args[:player])
  end

  def start_game
    Output.game_start(player.name, board.word.word.length)
    board.show
    play_game
  end

  def self.load_existing_game
    Output.load
    return {} if gets.chomp == 'no'

    Hangman.load_game('Tom')
  end

  def play_game
    until game_finished?
      save_current_game
      guess = player.make_guess
      board.update(guess)
    end
    end_game
  end

  def save_current_game
    Output.save
    return unless gets.chomp == 'yes'

    Hangman.save_game(board, player)
  end

  def end_game
    board.word.word_finished? ? Output.winner_announcement(player.name) : Output.loser_announcement(board.word.word)
  end

  def game_finished?
    board.word.word_finished? || board.gallow.hangman_completed?
  end
end

game_params = Hangman.load_existing_game
Hangman.new(game_params).start_game
