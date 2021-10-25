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
      expect(player.comp_shot).to include(0)
    end
  end
end
