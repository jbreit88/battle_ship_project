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
    end

    it 'has a submarine' do
      expect(player.player_submarine).to be_an_instance_of(Ship)

      expect(player.player_submarine.health).to eq 2
    end
  end

  describe '#comp_shot' do
    it 'selects coordinate at random' do
      expect(player.player_board.cells.keys).to include(player.comp_shot)
    end
  end

  describe '#comp_shot_test' do
    xit 'checks if computer shot is logged' do
      player.player_board.place(cruiser, ["A1", "A2", "A3"])

      expect(player.comp_shot_test("A4")).to eq("A4 is a miss!")
      expect(player.player_board.cells["A4"].fired_upon?).to be true
    end

    xit 'checks if computer shot logs hit' do
      player.player_board.place(cruiser, ["A1", "A2", "A3"])

      expect(player.comp_shot_test("A1")).to eq("A1 is a hit!")
      expect(player.player_board.cells["A1"].fired_upon?).to be true
    end

    xit 'checks if computer shot logs sink' do
      player.player_board.place(cruiser, ["A1", "A2", "A3"])
      player.comp_shot_test("A2")
      player.comp_shot_test("A3")

      expect(player.comp_shot_test("A1")).to eq("You sunk my Cruiser!")
      expect(player.player_board.cells["A1"].fired_upon?).to be true
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
