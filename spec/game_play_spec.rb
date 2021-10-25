require "rspec"
require './lib/ship'
require "./lib/board"
require './lib/cell'
require './lib/game_play.rb'

describe GamePlay do #John's Tests

let(:game) {GamePlay.new}
let(:cruiser) {cruiser = Ship.new("Cruiser", 3)}
let(:submarine) {submarine = Ship.new("Submarine", 2)}
# let(:cpu) {board = Board.new}

it '#comp_ship_place' do
  game.comp_ship_place
  
  expect(game.comp_board.cells.count { |key, value| value.ship != nil }).to eq(3)
end


end


RSpec.describe GamePlay do #Brad's Tests





end
