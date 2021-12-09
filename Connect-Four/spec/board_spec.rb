require_relative '../lib/board'

describe Board do
  let(:board) { Board.new }
  let(:column_count) { 7 }
  let(:row_count) { 6 }

  context 'the initialized attributes are according to the ruleset' do
    it 'has a fixed number of rows' do
      expect(board.rows).to eq(row_count)
    end

    it 'has a fix number of columns' do
      expect(board.columns).to eq(column_count)
    end
  end

  describe '.valid_column?' do # für eigenständige methoden immer describe benutzen
    context 'when column is empty' do
      it ' return true for valid column numbers' do
        expect(board.valid_column?(column_count - 1)).to be true
        expect(board.valid_column?(0)).to be true
      end
      it 'return false for invalid column numbers' do
        expect(board.valid_column?(column_count)).to be false
        expect(board.valid_column?(-1)).to be false
      end
    end
    context 'when column is full' do
      let(:column) { 4 }
      let(:row_count) { 6 }
      it ' return false for full column' do
        row_count.times do
          board.update(column, '©')
          board.update(column - 1, 'å')
        end
        expect(board.valid_column?(column)).to be false
      end
    end
  end

  describe '.update' do
    let(:second_board) { Board.new }
    let(:column) { 4 }
    let(:max_row) { 6 }
    let(:symbol)  { '†' }
    it 'updates tile in column 4' do
      expect(second_board.grid[max_row - 1][column]).not_to eq(symbol)
      second_board.update(column, symbol)
      expect(second_board.grid[max_row - 1][column]).to eq(symbol)
    end
    it 'updates tile in column 4 and row 5 because column 4 row 6 is already occupied' do
      expect(second_board.grid[max_row - 2][column]).not_to eq(symbol)
      second_board.update(column, symbol)
      second_board.update(1, 'å') # turn of player 2, not of interest but needed to be able to make the 2nd move for the player
      second_board.update(column, symbol)
      expect(second_board.grid[max_row - 2][column]).to eq(symbol)
    end
    it 'returns error message when the same palyer plays 2 turns in a row' do
      second_board.update(column, symbol)
      second_board.update(column, symbol)
      expect(second_board.update(column, symbol)).to eq('You are not allowed to play two turns in a row')
    end
  end

  describe '.game_over?' do
    let(:symbol_one) { '†' }
    let(:symbol_two) { 'å' }
    it 'has four vertical discs' do
      vertical_board = Board.new
      vertical_board.update(1, symbol_one)
      vertical_board.update(2, symbol_two)
      vertical_board.update(1, symbol_one)
      vertical_board.update(2, symbol_two)
      vertical_board.update(1, symbol_one)
      vertical_board.update(2, symbol_two)
      vertical_board.update(1, symbol_one)
      expect(vertical_board.game_over?).to be true
    end
    it 'has four horizontal discs' do
      horizontal_board = Board.new
      horizontal_board.update(1, symbol_one)
      horizontal_board.update(1, symbol_two)
      horizontal_board.update(2, symbol_one)
      horizontal_board.update(1, symbol_two)
      horizontal_board.update(3, symbol_one)
      horizontal_board.update(1, symbol_two)
      horizontal_board.update(4, symbol_one)
      expect(horizontal_board.game_over?).to be true
    end
    it 'has four diagonal discs' do
      diagonal_board = Board.new
      diagonal_board.update(1, symbol_one)
      diagonal_board.update(1, symbol_two)
      diagonal_board.update(1, symbol_one)
      diagonal_board.update(5, symbol_two)
      diagonal_board.update(1, symbol_one)
      diagonal_board.update(5, symbol_two)
      diagonal_board.update(2, symbol_one)
      diagonal_board.update(2, symbol_two)
      diagonal_board.update(2, symbol_one)
      diagonal_board.update(3, symbol_two)
      diagonal_board.update(3, symbol_one)
      diagonal_board.update(5, symbol_two)
      diagonal_board.update(4, symbol_one)
      expect(diagonal_board.game_over?).to be true
    end
    it 'has four reversed diagonal discs' do
      diagonal_board = Board.new
      diagonal_board.update(1, symbol_one)
      diagonal_board.update(1, symbol_two)
      diagonal_board.update(2, symbol_one)
      diagonal_board.update(1, symbol_two)
      diagonal_board.update(2, symbol_one)
      diagonal_board.update(3, symbol_two)
      diagonal_board.update(3, symbol_one)
      diagonal_board.update(1, symbol_two)
      diagonal_board.update(3, symbol_one)
      diagonal_board.update(4, symbol_two)
      diagonal_board.update(4, symbol_one)
      diagonal_board.update(4, symbol_two)
      diagonal_board.update(4, symbol_one)
      expect(diagonal_board.game_over?).to be true
    end
    it 'returns false without win condition' do
      expect(board.game_over?).to be false
    end
  end
end
