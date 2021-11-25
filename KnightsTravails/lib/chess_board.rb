require_relative 'chess_tile'
require_relative 'knight'

class ChessBoard
  MAX_SIZE = 8
  MIN_SIZE = 1

  attr_reader :knight, :current_occupied_tile, :target_tile

  def initialize
    @board = create_board
    @knight = Knight.new(starting_point)
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

  def knight_moves
    knight.history << knight.current_position

    if knight.current_position == target_tile
      puts "The knight has arrived at #{knight.current_position}. His turns where #{knight.history}"
      return nil
    end

    possible_moves = knight.possible_moves
    possible_moves.each do |move|
      knight.current_position = move
      knight_moves
    end
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
end
ChessBoard.new.knight_moves
