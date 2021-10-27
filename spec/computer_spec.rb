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
      expected = "  1 2 3 4\nA \e[35m.\e[0m \e[35m.\e[0m \e[35m.\e[0m \e[35m.\e[0m\nB \e[35m.\e[0m \e[35m.\e[0m \e[35m.\e[0m \e[35m.\e[0m\nC \e[35m.\e[0m \e[35m.\e[0m \e[35m.\e[0m \e[35m.\e[0m\nD \e[35m.\e[0m \e[35m.\e[0m \e[35m.\e[0m \e[35m.\e[0m\n"
      expect(computer.cpu_display_board).to eq(expected)
    end
  end

  describe '#player_input' do
    it 'checks it gets input' do
      allow($stdin).to receive(:gets).and_return("a4\n")

      expect(computer.player_input).to eq("A4")
    end
  end

  describe '#player_shot' do
    it 'misses at A1' do
      allow(computer).to receive(:player_input).and_return("A1")

      computer.comp_board.place(cruiser, ["A2", "A3", "A4"])
      computer.player_shot # At user input prompt "A1"
      # computer.player_shot # If at "A1" a second time renders "Invalid selection" message.
      expect(computer.comp_board.render).to eq("  1 2 3 4\nA M . . .\nB . . . .\nC . . . .\nD . . . .\n")
      expect(computer.comp_board.cells["A1"].fired_upon?).to be true

      expect(computer.comp_board.cells["A1"].render).to eq("M")
    end

    it 'hits at A3' do
      allow(computer).to receive(:player_input).and_return("A3")

      computer.comp_board.place(cruiser, ["A2", "A3", "A4"])

      computer.player_shot

      expect(computer.comp_board.cells["A3"].fired_upon?).to be true

      expect(computer.comp_board.cells["A3"].render).to eq("H")

      expect(computer.comp_board.render).to eq("  1 2 3 4\nA . . H .\nB . . . .\nC . . . .\nD . . . .\n")
    end

    it 'renders a sunk ship' do
      allow(computer).to receive(:player_input).and_return("A3")

      cruiser.hit
      cruiser.hit

      computer.comp_board.place(cruiser, ["A2", "A3", "A4"])

      computer.player_shot

      expect(computer.comp_board.cells["A3"].fired_upon?).to be true

      expect(computer.comp_board.render).to eq("  1 2 3 4\nA . . X .\nB . . . .\nC . . . .\nD . . . .\n")
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
