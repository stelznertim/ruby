class Knight
  attr_accessor :current_position
  attr_reader :side_movement_range, :forward_movement_range

  def initialize(tile = nil)
    @current_position = tile
    @forward_movement_range = 2
    @side_movement_range = 1
  end
end
