require_relative '../lib/board'

describe Board do
  let(:board) { Board.new }
  context 'check that board is initialized correctly' do
    it 'initialized rows correctly' do
      expect(board.rows).to eq(6)
    end
    it 'intializes columns correctly' do
      expect(board.columns).to eq(7)
    end
    it 'initializes the grid correctly' do
      expect(board.grid.flatten.size).to eq(42)
    end
  end

  context 'check for valid_turn? ' do
    it 'is valid turn' do
      column = 5
      expect(board.valid_turn?(column)).to be true
    end
    it 'is not a valid turn ' do
      column = 20
      expect(board.valid_turn?(column)).to be false
    end
  end

  context 'update the grid' do
    let(:second_board) { Board.new }
    column = 4
    max_row = 6
    symbol = 'o'
    it 'changes the grid with update' do
      second_board.update(column, symbol)
      expect(second_board.grid).not_to eq(board.grid)
    end
    it 'places symbol in correct grid column' do
      second_board.update(column, symbol)
      expect(second_board.grid[max_row - 1][column - 1]).to eq(symbol)
    end
    it 'places symbol on lowest possible grid row if the layer below has already a symbol it must go  a row up' do
      second_board.update(column, symbol)
      second_board.update(column, symbol)
      expect(second_board.grid[max_row - 2][column - 1]).to eq(symbol)
    end
  end
end
