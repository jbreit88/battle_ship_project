require "rspec"
require './lib/ship'
require "./lib/board"
require './lib/cell'
require './lib/computer'
require './lib/player'

describe Computer do #John's Tests

  let(:computer) {Computer.new}
  let(:cruiser) {cruiser = Ship.new("Cruiser", 3)}
  let(:submarine) {submarine = Ship.new("Submarine", 2)}

  # let(:cpu) {board = Board.new}


  it '#comp_ship_place' do
    computer.comp_ship_place

    expect(computer.comp_board.cells.count { |key, value| value.ship != nil }).to eq(5)
  end

  describe '#player_shot' do
    it 'fires upon user chosen cell' do
      computer.comp_board.place(cruiser, ["A2", "A3", "A4"])
      computer.player_shot # If at A1
      # computer.player_shot # If at A1 a second time renders "Invalid selection" message.
      expect(computer.comp_board.render).to eq("  1 2 3 4\nA M . . .\nB . . . .\nC . . . .\nD . . . .\n")

      computer.player_shot # If at A3
      expect(computer.comp_board.render).to eq("  1 2 3 4\nA M . H .\nB . . . .\nC . . . .\nD . . . .\n")
    end
  end
end
