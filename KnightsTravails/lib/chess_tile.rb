class ChessTile
  def initialize(coordinate)
    @tile_coordinate = coordinate
    @occupied_by_knight = false
    @was_occupied = false
  end
end
