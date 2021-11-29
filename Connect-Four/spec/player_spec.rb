require_relative '../lib/player'

# ------ requirements of the player class ------
#   have a name and a symbol for your disc
#   choose a column to put in your disc
#

describe Player do
  let(:player) { Player.new('Tim', '▵') }
  context 'check if player attributes are initialized correctly' do
    it 'has right name' do
      expect(player.name).to eq('Tim')
    end

    it 'has right symbol for disc' do
      expect(player.symbol).to eq('▵')
    end
  end

  context 'let player put a disc in a column' do
    it 'player put disc in an allowed column' do
      column = 4
      expect(player.place_disc(column)).to be_valid_turn
    end

    it ' player put disc in a nonexistend column' do
      column = 20
      expect(player.place_disc(column)).not_to be_valid_turn
    end
  end
end
