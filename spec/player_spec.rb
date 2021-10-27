require "rspec"
require './lib/ship'
require "./lib/board"
require './lib/cell'
require './lib/computer'
require "./lib/player"

RSpec.describe Player do
  let(:player) {Player.new}
  let(:cruiser) {cruiser = Ship.new("Cruiser", 3)}
  let(:submarine) {submarine = Ship.new("Submarine", 2)}

  describe '#initialize' do
    it 'exists' do
      expect(player).to be_an_instance_of(Player)
    end

    it 'has a cruiser' do
      expect(player.player_cruiser).to be_an_instance_of(Ship)

      expect(player.player_cruiser.health).to eq 3

      expect(player.player_cruiser.name).to eq "Cruiser"
    end

    it 'has a submarine' do
      expect(player.player_submarine).to be_an_instance_of(Ship)

      expect(player.player_submarine.health).to eq 2

      expect(player.player_submarine.name).to eq "Submarine"
    end
  end

  describe '#player_input_method' do
    it 'gets user input and alters it' do
      allow($stdin).to receive(:gets).and_return("a1")

      expect(player.player_input_method).to eq(["A1"])
    end

    it 'gets multiple coordinates' do
      allow($stdin).to receive(:gets).and_return("a1 a2")

      expect(player.player_input_method).to eq(["A1", "A2"])
    end
  end

  describe '#player_ship_place_cruiser' do
    it 'places cruiser at coordinates' do
      allow(player).to receive(:player_input_method).and_return(["A1", "A2", "A3"])

      player.player_ship_place_cruiser

      expected = "  1 2 3 4\nA \e[34mS\e[0m \e[34mS\e[0m \e[34mS\e[0m \e[35m.\e[0m\nB \e[35m.\e[0m \e[35m.\e[0m \e[35m.\e[0m \e[35m.\e[0m\nC \e[35m.\e[0m \e[35m.\e[0m \e[35m.\e[0m \e[35m.\e[0m\nD \e[35m.\e[0m \e[35m.\e[0m \e[35m.\e[0m \e[35m.\e[0m\n"
      expect(player.player_board_render).to eq(expected)
    end
  end

  describe '#player_ship_place_submarine' do
    it 'places submarine at coordinates' do
      allow(player).to receive(:player_input_method).and_return(["B1", "C1"])

      player.player_ship_place_submarine

      expected = "  1 2 3 4\nA \e[35m.\e[0m \e[35m.\e[0m \e[35m.\e[0m \e[35m.\e[0m\nB \e[34mS\e[0m \e[35m.\e[0m \e[35m.\e[0m \e[35m.\e[0m\nC \e[34mS\e[0m \e[35m.\e[0m \e[35m.\e[0m \e[35m.\e[0m\nD \e[35m.\e[0m \e[35m.\e[0m \e[35m.\e[0m \e[35m.\e[0m\n"
      expect(player.player_board_render).to eq(expected)
    end
  end

  describe '#computer_input' do
    it 'generates a cell for the computer to fire at' do
      allow(player.player_board).to receive(:cells).and_return({"A1" => 1})

      expect(player.computer_input).to eq("A1")
    end
  end

  describe '#comp_shot' do
    it 'selects coordinate at random' do
      expect(player.player_board.cells.keys).to include(player.comp_shot)
    end

    it 'checks if computer shot is logged' do
      allow(player.player_board).to receive(:cells).and_return({"A1" => Cell.new("A1")})

      player.player_board.place(cruiser, ["A2", "A3", "A4"])

      player.comp_shot

      expect(player.player_board.cells["A1"].fired_upon?).to be true

      expect(player.player_board.cells["A1"].render).to eq "\e[33mM\e[0m"
    end

    it 'checks if computer shot is hit' do
      allow(player).to receive(:computer_input).and_return(player.player_board.cells.keys[0])

      player.player_board.place(cruiser, ["A1", "A2", "A3"])

      player.comp_shot

      expect(player.player_board.cells["A1"].fired_upon?).to be true

      expect(player.player_board.cells["A1"].render).to eq "\e[32mH\e[0m"
      
      expected = "  1 2 3 4\nA \e[32mH\e[0m \e[34mS\e[0m \e[34mS\e[0m \e[35m.\e[0m\nB \e[35m.\e[0m \e[35m.\e[0m \e[35m.\e[0m \e[35m.\e[0m\nC \e[35m.\e[0m \e[35m.\e[0m \e[35m.\e[0m \e[35m.\e[0m\nD \e[35m.\e[0m \e[35m.\e[0m \e[35m.\e[0m \e[35m.\e[0m\n"
      expect(player.player_board_render).to eq(expected)
    end

    it 'checks if computer shot is sink' do
      allow(player).to receive(:computer_input).and_return(player.player_board.cells.keys[0])

      cruiser.hit
      cruiser.hit

      player.player_board.place(cruiser, ["A1", "A2", "A3"])

      player.comp_shot

      expect(player.player_board.cells["A1"].fired_upon?).to be true

      expect(player.player_board.cells["A1"].render).to eq "\e[31mX\e[0m"
    end
  end

  describe '#player_board_render' do
    it 'renders player board' do
      expected = "  1 2 3 4\nA \e[35m.\e[0m \e[35m.\e[0m \e[35m.\e[0m \e[35m.\e[0m\nB \e[35m.\e[0m \e[35m.\e[0m \e[35m.\e[0m \e[35m.\e[0m\nC \e[35m.\e[0m \e[35m.\e[0m \e[35m.\e[0m \e[35m.\e[0m\nD \e[35m.\e[0m \e[35m.\e[0m \e[35m.\e[0m \e[35m.\e[0m\n"
      expect(player.player_board_render).to eq(expected)
    end
  end

  describe '#all_sunk' do
    it 'checks if sub and cruiser have 0 health' do
      player.player_board.place(cruiser, ["A1", "A2", "A3"])
      player.player_board.place(submarine, ["B2", "C2"])

      player.player_cruiser.hit
      player.player_cruiser.hit
      player.player_cruiser.hit
      player.player_submarine.hit
      player.player_submarine.hit

      expect(player.player_cruiser.health).to eq 0
      expect(player.player_submarine.health).to eq 0
      expect(player.player_cruiser.sunk?).to eq true
      expect(player.player_submarine.sunk?).to eq true
      expect(player.all_sunk?).to be true
    end

    it 'returns false is cruiser has health' do
      player.player_board.place(cruiser, ["A1", "A2", "A3"])
      player.player_board.place(submarine, ["B2", "C2"])

      player.player_cruiser.hit
      player.player_cruiser.hit
      player.player_submarine.hit
      player.player_submarine.hit

      expect(player.player_cruiser.health).to eq 1
      expect(player.player_submarine.health).to eq 0
      expect(player.player_cruiser.sunk?).to eq false
      expect(player.player_submarine.sunk?).to eq true
      expect(player.all_sunk?).to be false
    end

    it 'returns false if submarine has health' do
      player.player_board.place(cruiser, ["A1", "A2", "A3"])
      player.player_board.place(submarine, ["B2", "C2"])

      player.player_cruiser.hit
      player.player_cruiser.hit
      player.player_cruiser.hit
      player.player_submarine.hit

      expect(player.player_cruiser.health).to eq 0
      expect(player.player_submarine.health).to eq 1
      expect(player.player_cruiser.sunk?).to eq true
      expect(player.player_submarine.sunk?).to eq false
      expect(player.all_sunk?).to be false
    end
  end
end
