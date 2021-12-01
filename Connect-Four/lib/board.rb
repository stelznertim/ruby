class Board
  attr_reader :rows, :columns, :grid

  def initialize
    @rows = 6
    @columns = 7
    @grid = Array.new(6) { Array.new(7) }
  end

  def valid_column?(input)
    return true if input < columns && check_rows(input)

    puts 'The column is not a valid selection. Please select another column.'
    false
  end

  def check_rows(input)
    grid.each do |row|
      return true if row[input].nil?
    end
    false
  end

  def update(column, symbol)
    grid.reverse.each_with_index do |row, row_index|
      next unless row[column].nil?

      grid.reverse[row_index][column] = symbol
      break
    end
    show
    grid
  end

  def game_over?(symbol)
    grid.each do |row|
      return true if check_grid_line(row, symbol)
    end

    grid.transpose.each do |column|
      return true if check_grid_line(column, symbol)
    end

    diagonals = find_diagonals(grid)
    diagonals.each do |diagonal|
      return true if check_grid_line(diagonal, symbol)
    end

    reverse_diagonals = find_diagonals(grid.reverse)
    reverse_diagonals.each do |reverse_diagonal|
      return true if check_grid_line(reverse_diagonal, symbol)
    end
    false
  end

  def check_grid_line(line, symbol)
    symbol_counter = 0
    line.each do |line_item|
      if line_item == symbol
        symbol_counter += 1
      else
        symbol_counter = 0
      end
      return true if symbol_counter == 4
    end
    false
  end

  def find_diagonals(grid)
    (0..grid.size - 4).map do |i|
      (0..grid.size - 1 - i).map { |j| grid[i + j][j] }
    end.concat((1..grid.first.size - 4).map do |j|
      (0..grid.size - j - 1).map { |i| grid[i][j + i] }
    end)
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

  def full?
    return false if grid.flatten.compact.size != grid.flatten.size

    true
  end
end
