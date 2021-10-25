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

  describe '#initialize' do
    it 'exists' do
      expect(computer).to be_an_instance_of(Computer)
    end

    it 'has a cruiser' do
      expect(computer.comp_cruiser).to be_an_instance_of(Ship)

      expect(computer.comp_cruiser.health).to eq 3
    end

    it 'has a submarine' do
      expect(computer.comp_submarine).to be_an_instance_of(Ship)

      expect(computer.comp_submarine.health).to eq 2
    end
  end

  describe '#comp_ship_place' do
    it 'puts two ships randomly on the board' do
      computer.comp_ship_place

      expect(computer.comp_board.cells.count { |key, value| value.ship != nil }).to eq(5)

      expect(computer.comp_board.render(true).chars.count("S")).to eq 5
    end
  end

  describe '#cpu_display_board' do
    it 'renders computer board' do
      expect(computer.cpu_display_board).to eq("  1 2 3 4\nA . . . .\nB . . . .\nC . . . .\nD . . . .\n")
    end
  end

  describe '#player_shot user input' do
    xit 'misses at A1' do
      computer.comp_board.place(cruiser, ["A2", "A3", "A4"])
      computer.player_shot # At user input prompt "A1"
      # computer.player_shot # If at "A1" a second time renders "Invalid selection" message.
      expect(computer.comp_board.render).to eq("  1 2 3 4\nA M . . .\nB . . . .\nC . . . .\nD . . . .\n")
    end

    xit 'hits at A3' do

      computer.comp_board.place(cruiser, ["A2", "A3", "A4"])
      computer.player_shot # At user input prompt "A3"

      expect(computer.comp_board.render).to eq("  1 2 3 4\nA . . H .\nB . . . .\nC . . . .\nD . . . .\n")
    end

    xit 'renders the board with more data' do # At user input prompts "A1", "B1", "C1", "A2", "B2", "C2", "A3", "B3", "C3", "D1", "D2", "D3"
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

    xit 'shows a sunk ship' do # At user input prompt "A2", "A3", "A4"
      computer.comp_board.place(cruiser, ["A2", "A3", "A4"])
      computer.player_shot
      computer.player_shot
      computer.player_shot

      expect(computer.comp_board.render).to eq("  1 2 3 4\nA . X X X\nB . . . .\nC . . . .\nD . . . .\n")
    end
  end

  describe '#player_shot_test no user input' do
    it 'misses at A1' do
      computer.comp_board.place(cruiser, ["A2", "A3", "A4"])
      computer.player_shot_test("A1")

      expect(computer.comp_board.render).to eq("  1 2 3 4\nA M . . .\nB . . . .\nC . . . .\nD . . . .\n")
    end

    it 'is invalid selection if shoot same cell twice' do
      computer.comp_board.place(cruiser, ["A2", "A3", "A4"])
      computer.player_shot_test("A1")

      expect(computer.player_shot_test("A1")).to eq("Not a valid selection, Please try again:")
    end

    it 'hits at A3' do
      computer.comp_board.place(cruiser, ["A2", "A3", "A4"])
      computer.player_shot_test("A3")

      expect(computer.comp_board.render).to eq("  1 2 3 4\nA . . H .\nB . . . .\nC . . . .\nD . . . .\n")
    end

    it 'renders the board with more data no user input' do
      computer.comp_board.place(cruiser, ["A2", "A3", "A4"])
      computer.player_shot_test("A1")
      computer.player_shot_test("B1")
      computer.player_shot_test("C1")
      computer.player_shot_test("A2")
      computer.player_shot_test("B2")
      computer.player_shot_test("C2")
      computer.player_shot_test("A3")
      computer.player_shot_test("B3")
      computer.player_shot_test("C3")
      computer.player_shot_test("D1")
      computer.player_shot_test("D2")
      computer.player_shot_test("D3")

      expect(computer.comp_board.render).to eq("  1 2 3 4\nA M H H .\nB M M M .\nC M M M .\nD M M M .\n")
    end

    it 'renders a sunk ship' do
      computer.comp_board.place(cruiser, ["A2", "A3", "A4"])
      computer.player_shot_test("A2")
      computer.player_shot_test("A3")
      computer.player_shot_test("A4")

      expect(computer.comp_board.render).to eq("  1 2 3 4\nA . X X X\nB . . . .\nC . . . .\nD . . . .\n")
    end
  end

  describe '#all_sunk' do
    it 'checks if sub and cruiser have 0 health' do
      computer.comp_board.place(cruiser, ["A1", "A2", "A3"])
      computer.comp_board.place(submarine, ["B2", "C2"])

      computer.comp_cruiser.hit
      computer.comp_cruiser.hit
      computer.comp_cruiser.hit
      computer.comp_submarine.hit
      computer.comp_submarine.hit

      expect(computer.comp_cruiser.health).to eq 0
      expect(computer.comp_submarine.health).to eq 0
      expect(computer.comp_cruiser.sunk?).to eq true
      expect(computer.comp_submarine.sunk?).to eq true
      expect(computer.all_sunk?).to be true
    end

    it 'returns false if cruiser has health' do
      computer.comp_board.place(cruiser, ["A1", "A2", "A3"])
      computer.comp_board.place(submarine, ["B2", "C2"])

      computer.comp_cruiser.hit
      computer.comp_cruiser.hit
      computer.comp_submarine.hit
      computer.comp_submarine.hit

      expect(computer.comp_cruiser.health).to eq 1
      expect(computer.comp_submarine.health).to eq 0
      expect(computer.comp_cruiser.sunk?).to eq false
      expect(computer.comp_submarine.sunk?).to eq true
      expect(computer.all_sunk?).to be false
    end

    it 'returns false if submarine has health' do
      computer.comp_board.place(cruiser, ["A1", "A2", "A3"])
      computer.comp_board.place(submarine, ["B2", "C2"])

      computer.comp_cruiser.hit
      computer.comp_cruiser.hit
      computer.comp_cruiser.hit
      computer.comp_submarine.hit


      expect(computer.comp_cruiser.health).to eq 0
      expect(computer.comp_submarine.health).to eq 1
      expect(computer.comp_cruiser.sunk?).to eq true
      expect(computer.comp_submarine.sunk?).to eq false
      expect(computer.all_sunk?).to be false
    end
  end
end
