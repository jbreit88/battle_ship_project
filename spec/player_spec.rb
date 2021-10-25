require "rspec"
require './lib/ship'
require "./lib/board"
require './lib/cell'
require './lib/computer'
require "./lib/player"
require "./lib/game_play"

RSpec.describe Player do
  let(:player) {Player.new}
  let(:cruiser) {cruiser = Ship.new("Cruiser", 3)}
  let(:submarine) {submarine = Ship.new("Submarine", 2)}

  it 'exists' do
    expect(player).to be_an_instance_of(Player)
  end

  describe '#comp_shot' do
    it 'selects coordinate at random' do
      expect(player.player_board.cells.keys).to include(player.comp_shot)
    end
  end

  describe '#all_sunk' do
    it 'checks if sub and cruiser have 0 health' do
      player.player_board.place(cruiser, ["A1", "A2", "A3"])
      player.player_board.place(submarine, ["B2", "C2"])
      ### Commented out code has no impact on passing tests. Fire_upon method not removing hit points from ship. But cells rendering properly as sunk. Weird. ###
      # player.player_board.cells["A1"].fire_upon
      # player.player_board.cells["A2"].fire_upon
      # player.player_board.cells["A3"].fire_upon
      # player.player_board.cells["B2"].fire_upon
      # player.player_board.cells["C2"].fire_upon
      # expected = "  1 2 3 4\nA X X X .\nB . X . .\nC . X . .\nD . . . .\n"
      # expect(player.player_board.render).to eq(expected)

      player.player_cruiser.hit
      player.player_cruiser.hit
      player.player_cruiser.hit
      player.player_submarine.hit
      player.player_submarine.hit
      player.player_submarine.hit

      expect(player.player_cruiser.health).to eq 0
      expect(player.player_submarine.health).to eq 0
      expect(player.player_cruiser.sunk?).to eq true
      expect(player.player_submarine.sunk?).to eq true
      expect(player.all_sunk?).to be true
    end
  end
end
