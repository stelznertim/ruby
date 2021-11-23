class Knight
  attr_accessor :current_placement

  def initialize
    @current_placement = nil
    @forward_movement_range = 2
    @side_movement_range = 1
  end
end
