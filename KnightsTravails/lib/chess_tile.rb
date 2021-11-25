class ChessTile
  def initialize(coordinate, parent = nil)
    @tile_coordinate = coordinate
    @occupied_by_knight = false
    @parent = parent
  end
end
