require_relative '../lib/player'
require_relative '../lib/board'

# ------ requirements of the player class ------
#   have a name and a symbol for your disc
#   choose a column to put in your disc
#

describe Player do
  let(:player) { Player.new('Tim', '▵') }
  context 'player gets correctly initialized' do
    it 'Tim is correct Name' do
      expect(player.name).to eq('Tim')
    end

    it '▵ is the used symbol' do
      expect(player.symbol).to eq('▵')
    end
  end
  context ' player gets initialized falsely' do
    it 'Marianne is wrong Name' do
      expect(player.name).not_to eq('Marianne')
    end

    it '√ is not the used symbol' do
      expect(player.symbol).not_to eq('√')
    end
  end
end
