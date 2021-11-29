require_relative '../lib/player'
require_relative '../lib/board'

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
      expect(player.disc).to eq('▵')
    end
  end

  context 'let player select a column for his disc' do
    it 'selects disc' do
      allow($stdin).to receive(:gets).and_return(4)
      column = $stdin.gets
      expect(column).to eq(4)
    end
  end
end
