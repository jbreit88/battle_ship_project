require "rspec"
require './lib/ship'
require "./lib/board"
require './lib/cell'
require './lib/computer'
require './lib/player'

describe Computer do

  let(:computer) {Computer.new}
  let(:cruiser) {cruiser = Ship.new("Cruiser", 3)}
  let(:submarine) {submarine = Ship.new("Submarine", 2)}

  it 'exists' do
    expect(computer).to be_an_instance_of(Computer)
  end

  it '#comp_ship_place' do
    computer.comp_ship_place

    expect(computer.comp_board.cells.count { |key, value| value.ship != nil }).to eq(5)
  end

  describe '#player_shot' do
    xit 'misses at A1' do
      computer.comp_board.place(cruiser, ["A2", "A3", "A4"])
      computer.player_shot # If at A1
      # computer.player_shot # If at A1 a second time renders "Invalid selection" message.
      expect(computer.comp_board.render).to eq("  1 2 3 4\nA M . . .\nB . . . .\nC . . . .\nD . . . .\n")
    end

    xit 'hits at A3' do

      computer.comp_board.place(cruiser, ["A2", "A3", "A4"])
      computer.player_shot

      expect(computer.comp_board.render).to eq("  1 2 3 4\nA . . H .\nB . . . .\nC . . . .\nD . . . .\n")
    end

    xit 'renders the board with more data' do # Input A1, B1, C1, A2, B2, C2, A3, B3, C3, D1, D2, D3
      computer.comp_board.place(cruiser, ["A2", "A3", "A4"])
      computer.player_shot
      computer.player_shot
      computer.player_shot
      computer.player_shot
      computer.player_shot
      computer.player_shot
      computer.player_shot
      computer.player_shot
      computer.player_shot
      computer.player_shot
      computer.player_shot
      computer.player_shot

      expect(computer.comp_board.render).to eq("  1 2 3 4\nA M H H .\nB M M M .\nC M M M .\nD M M M .\n")
    end

    xit 'shows a sunk ship' do # Input A2, A3, A4
      computer.comp_board.place(cruiser, ["A2", "A3", "A4"])
      computer.player_shot
      computer.player_shot
      computer.player_shot

      expect(computer.comp_board.render).to eq("  1 2 3 4\nA . X X X\nB . . . .\nC . . . .\nD . . . .\n")
    end
  end
end
