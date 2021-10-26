require "rspec"
require './lib/ship'
require "./lib/board"
require './lib/cell'
require './lib/game_play'
require './lib/computer'

describe GamePlay do #John's Tests

let(:game) {GamePlay.new}
let(:cruiser) {cruiser = Ship.new("Cruiser", 3)}
let(:submarine) {submarine = Ship.new("Submarine", 2)}



it '#comp_ship_place' do
  game.computer_place_ships

  expect(game.computer.comp_board.cells.count { |key, value| value.ship != nil }).to eq(5)
end


end


RSpec.describe GamePlay do #Brad's Tests





end
