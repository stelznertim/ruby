require_relative '../lib/main'

# ------ requirements ------
# create 2 players and a board
# let name and symbol be player input
# start game when initialized
# play rounds until board is full or a player has won
# end the game when either condition is met

describe Game do
  let(:game) { Game.new }

  context 'does not play round with wrong input' do
    it ' input 25 is not a valid input' do
      first_player.select_column(25)
      expect(game.play_round?).to eq false
    end
    it ' input 4 on a full column is not valid' do
    end
  end
  context 'stops game on full board' do
  end

  context 'stops game on win' do
  end
end
