class Board
  attr_reader :rows, :columns, :grid

  def initialize
    @rows = 6
    @columns = 7
    @grid = Array.new(6) { Array.new(7) }
  end

  def valid_turn?(input)
    input < columns ? check_rows(input) : false
  end

  def check_rows(input)
    grid.each do |row|
      return true if row[input - 1].nil?
    end
    false
  end

  def update(column, symbol)
    grid.reverse.each_with_index do |row, row_index|
      next unless row[column - 1].nil?

      grid.reverse[row_index][column - 1] = symbol
      break
    end

    grid
  end

  def show
    puts <<-BOARD
    #{grid[0][0]} | #{grid[0][1]} | #{grid[0][2]} | #{grid[0][3]} | #{grid[0][4]} | #{grid[0][5]} | #{grid[0][6]}
    -+--+--+--+--+--+--
    #{grid[1][0]} | #{grid[1][1]} | #{grid[1][2]} | #{grid[1][3]} | #{grid[1][4]} | #{grid[1][5]} | #{grid[1][6]}
    -+--+--+--+--+--+--
    #{grid[2][0]} | #{grid[2][1]} | #{grid[2][2]} | #{grid[2][3]} | #{grid[2][4]} | #{grid[2][5]} | #{grid[2][6]}
    -+--+--+--+--+--+-
    #{grid[3][0]} | #{grid[3][1]} | #{grid[3][2]} | #{grid[3][3]} | #{grid[3][4]} | #{grid[3][5]} | #{grid[3][6]}
    -+--+--+--+--+--+-
    #{grid[4][0]} | #{grid[4][1]} | #{grid[4][2]} | #{grid[4][3]} | #{grid[4][4]} | #{grid[4][5]} | #{grid[4][6]}
    -+--+--+--+--+--+-
    #{grid[5][0]} | #{grid[5][1]} | #{grid[5][2]} | #{grid[5][3]} | #{grid[5][4]} | #{grid[5][5]} | #{grid[5][6]}
    BOARD
  end
end
Board.new.show
