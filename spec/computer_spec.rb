require "rspec"
require './lib/ship'
require "./lib/board"
require './lib/cell'
require './lib/computer'

describe Computer do #John's Tests

  let(:computer) {Computer.new}
  let(:cruiser) {cruiser = Ship.new("Cruiser", 3)}
  let(:submarine) {submarine = Ship.new("Submarine", 2)}
  # let(:cpu) {board = Board.new}

  it '#comp_ship_place' do
    computer.comp_ship_place

    expect(computer.comp_board.cells.count { |key, value| value.ship != nil }).to eq(3)
  end
end 
