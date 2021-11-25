class Knight
  attr_accessor :current_position
  attr_reader :side_movement_range, :forward_movement_range, :history

  MOVES = [[2, 1], [1, 2], [2, -1], [1, -2], [-1, 2], [-2, 1], [-2, -1], [-1, -2]].freeze
  MAX_SIZE = 7
  MIN_SIZE = 0

  def initialize(tile)
    @current_position = tile
    @forward_movement_range = 2
    @side_movement_range = 1
    @history = []
  end

  def possible_moves
    all_moves = []
    MOVES.each do |item|
      new_coordinate = [current_position, item].transpose.map { |x| x.reduce(:+) }
      next unless new_coordinate[0].between?(MIN_SIZE, MAX_SIZE) && new_coordinate[1].between?(MIN_SIZE, MAX_SIZE)

      all_moves << new_coordinate unless @history.include?(new_coordinate)
    end
    all_moves
  end
end
