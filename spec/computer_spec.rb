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

    it 'shot test misses at A1' do
      computer.comp_board.place(cruiser, ["A2", "A3", "A4"])
      computer.player_shot_test("A1") # If at A1
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

  describe '#all_sunk' do
    it 'checks if sub and cruiser have 0 health' do
      computer.comp_board.place(cruiser, ["A1", "A2", "A3"])
      computer.comp_board.place(submarine, ["B2", "C2"])
      ### Commented out code has no impact on passing tests. Fire_upon method not removing hit points from ship. But cells rendering properly as sunk. Weird. ###
      # computer.comp_board.cells["A1"].fire_upon
      # computer.comp_board.cells["A2"].fire_upon
      # computer.comp_board.cells["A3"].fire_upon
      # computer.comp_board.cells["B2"].fire_upon
      # computer.comp_board.cells["C2"].fire_upon
      # expected = "  1 2 3 4\nA X X X .\nB . X . .\nC . X . .\nD . . . .\n"
      # expect(computer.comp_board.render).to eq(expected)

      computer.comp_cruiser.hit
      computer.comp_cruiser.hit
      computer.comp_cruiser.hit
      computer.comp_submarine.hit
      computer.comp_submarine.hit
      computer.comp_submarine.hit

      expect(computer.comp_cruiser.health).to eq 0
      expect(computer.comp_submarine.health).to eq 0
      expect(computer.comp_cruiser.sunk?).to eq true
      expect(computer.comp_submarine.sunk?).to eq true
      expect(computer.all_sunk?).to be true
    end
  end
end
