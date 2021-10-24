require "rspec"
require './lib/ship'
require "./lib/board"
require './lib/cell'
require './lib/computer'

describe Computer do #John's Tests

  let(:computer) {Computer.new}
  let(:cruiser) {cruiser = Ship.new("Cruiser", 3)}
  let(:submarine) {submarine = Ship.new("Submarine", 2)}
<<<<<<< HEAD
=======
  # let(:cpu) {board = Board.new}
>>>>>>> 47079588032a55f80b968c8392c766239b9a2272

  it '#comp_ship_place' do
    computer.comp_ship_place

<<<<<<< HEAD
    expect(computer.comp_board.cells.count { |key, value| value.ship != nil }).to eq(5)
  end
end
=======
    expect(computer.comp_board.cells.count { |key, value| value.ship != nil }).to eq(3)
  end
end 
>>>>>>> 47079588032a55f80b968c8392c766239b9a2272
