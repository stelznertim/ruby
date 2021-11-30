require_relative '../lib/board'

describe Board do
  let(:board) { Board.new }
  context 'the initialized attributes of board are right' do
    it 'the number of rows is 6' do
      expect(board.rows).to eq(6)
    end

    it 'the number of columns is 7' do
      expect(board.columns).to eq(7)
    end
  end

  context 'the initialized attributes of board are wrong' do
    it ' the number of rows is not 7' do
      expect(board.rows).not_to eq(7)
    end
    it 'the number of columns is not 8' do
      expect(board.columns).not_to eq(8)
    end
  end

  context 'the column is valid' do
    it '5 is a valid column' do
      expect(board.valid_column?(5)).to be true
    end
  end

  context ' the column is not valid ' do
    it '20 is not a valid column' do
      expect(board.valid_column?(20)).to be false
    end
  end
  context ' the column is full' do
    before do
      column = 4
      6.times do
        board.update(column, '©')
      end
    end
    it 'a full column 4 is not valid' do
      expect(board.valid_column?(4)).not_to be true
    end
  end

  context 'grid updates' do
    second_board = Board.new
    column = 4
    max_row = 6
    symbol = 'o'
    it 'updates tile in column 4' do
      second_board.update(column, symbol)
      expect(second_board.grid[max_row - 1][column - 1]).to eq(symbol)
    end
    it 'updates tile in column 4 and row 5 because column 4 row 6 is already occupied' do
      second_board.update(column, symbol)
      second_board.update(column, symbol)
      expect(second_board.grid[max_row - 2][column - 1]).to eq(symbol)
    end
  end

  context 'game is over' do
    it 'has four vertical discs' do
      vertical_board = Board.new
      vertical_board.update(1, '†')
      vertical_board.update(1, '†')
      vertical_board.update(1, '†')
      vertical_board.update(1, '†')
      expect(vertical_board.game_over?('†')).to be true
    end
    it 'has four horizontal discs' do
      horizontal_board = Board.new
      horizontal_board.update(1, '†')
      horizontal_board.update(2, '†')
      horizontal_board.update(3, '†')
      horizontal_board.update(4, '†')
      expect(horizontal_board.game_over?('†')).to be true
    end
    it 'has four diagonal discs' do
      diagonal_board = Board.new
      diagonal_board.update(1, '†')
      diagonal_board.update(1, '†')
      diagonal_board.update(1, '†')
      diagonal_board.update(1, '†')
      diagonal_board.update(2, '†')
      diagonal_board.update(2, '†')
      diagonal_board.update(2, '†')
      diagonal_board.update(3, '†')
      diagonal_board.update(3, '†')
      diagonal_board.update(4, '†')
      expect(diagonal_board.game_over?('†')).to be true
    end
  end

  context 'game is not over' do
    it 'fulfills no win condition' do
      expect(board.game_over?('†')).not_to be true
    end
  end
end
