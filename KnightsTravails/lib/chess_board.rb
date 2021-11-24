require_relative 'chess_tile'
require_relative 'knight'

class ChessBoard
  MAX_SIZE = 8
  MIN_SIZE = 1
  MOVES = [[2, 1], [1, 2], [2, -1], [1, -2], [-1, 2], [-2, 1], [-2, -1], [-1, -2]].freeze

  attr_reader :knight, :current_occupied_tile

  def initialize
    @knight = Knight.new
    @board = create_board
    @current_occupied_tile = starting_point
    @target_tile = target_point
  end

  def starting_point
    puts 'Please Enter the starting point coordinates for the knight. x-coordinate:   '
    x = gets.chomp
    puts 'y-coordinate: '
    y = gets.chomp
    [x.to_i, y.to_i]
  end

  def target_point
    puts 'Please Enter the end point coordinates for the knight. x-coordinate:   '
    x = gets.chomp
    puts 'y-coordinate: '
    y = gets.chomp
    [x.to_i, y.to_i]
  end

  def knight_moves(_start_tile, _target_tile)
    knight.current_position = current_occupied_tile

    possible_moves = possible_moves(knight.current_position)
    find_best_move(possible_moves)
  end

  def create_board
    board = []
    MAX_SIZE.times do |width|
      MAX_SIZE.times do |height|
        board << ChessTile.new([width, height])
      end
    end
    pp board
  end

  def possible_moves(current_position)
    all_moves = []

    MOVES.each do |item|
      all_moves << [current_position, item].transpose.map { |x| x.reduce(:+) }
    end
    all_moves.filter! { |item| item[0].between?(MIN_SIZE, MAX_SIZE) && item[1].between?(MIN_SIZE, MAX_SIZE) }
  end

  def find_best_move(possible_moves, target_tile)
    # from the possible moves find which move is best suited to get to the target_tile on the fastest way
  end

  def print_out
    # just a helper method while coding to check instance values
    pp current_occupied_tile
    pp @target_tile
  end
end
ChessBoard.new
