require "rspec"
require './lib/ship'
require "./lib/board"
require './lib/ship'
require './lib/cell'

describe Board do
  it 'exists' do
    board = Board.new

    expect(board).to be_an_instance_of(Board)
  end

  it 'attributes' do
    board = Board.new

    expect(board.cells).to be_a(Hash)
    expect(board.cells.keys.length).to eq(16)
  end

  it 'can validate coordinates' do
    board = Board.new

    expect(board.valid_coordinate?("A1")).to be(true)
    expect(board.valid_coordinate?("D4")).to be(true)
    expect(board.valid_coordinate?("A5")).to be(false)
    expect(board.valid_coordinate?("E1")).to be(false)
    expect(board.valid_coordinate?("A22")).to be(false)
  end
end

describe 'validating ship placements' do
  let(:board) {Board.new}
  let(:cruiser) {Ship.new("Cruiser", 3)}
  let(:submarine) {Ship.new("Submarine", 2)}

  it '#cords to integers' do
    expect(board.cords_to_integers(["A1", "A2"])).to be_an(Array)
    expect(board.cords_to_integers(["A1", "A2"])).to eq([1, 2])
    expect(board.cords_to_integers(["A1", "A1", "A3"])).to eq([1, 1, 3])
  end

  it '#cord_letters_to_integers' do
    expect(board.cord_letters_to_integers(["A1", "A2"])).to be_an(Array)
    expect(board.cord_letters_to_integers(["A1", "A2"])).to eq([65, 65])
  end

  it '#single_letter_use' do
    expect(board.single_letter(["A1", "A2"])).to eq(true)
    expect(board.single_letter(["A1", "B1"])).to eq(false)
  end

  it 'checks if coordinates only have one numer for each value' do
    expect(board.single_number(["A1", "B1", "C1"])).to be true
    expect(board.single_number(["B1", "C1", "D1"])).to be true
  end

  it '#ascending numbers' do
    expect(board.ascending_numbers(["A1", "A2", "A3"])).to be(true)
    expect(board.ascending_numbers(["A3", "A2", "A1"])).to be(false)
  end

  it '#descending numbers' do
    expect(board.descending_numbers(["A1", "A2", "A3"])).to be(false)
    expect(board.descending_numbers(["A3", "A2", "A1"])).to be(true)
  end

  it 'can turn numbers from cords into an invalid range' do
    expect(board.cord_to_ranges(["A1", "A1", "A3"])).to eq(2)
    expect(board.cord_to_ranges(["B3", "B3", "D4"])).to eq(2)
  end

  it 'can turn numbers from cords into a valid range' do
    expect(board.letters_to_ranges(["B3", "C3", "D3"])).to eq(1)
    expect(board.letters_to_ranges(["A2", "B2", "C2"])).to eq(1)
    expect(board.letters_to_ranges(["A2", "A3", "A4"])).to eq(1)
    expect(board.letters_to_ranges(["D1", "D2", "D3"])).to eq(1)
  end

  it 'can turn letters from cords into an invalid range' do
    expect(board.letters_to_ranges(["B3", "B3", "D4"])).to eq(2)
    expect(board.letters_to_ranges(["B2", "B2", "D2"])).to eq(2)
    expect(board.letters_to_ranges(["A3", "A3", "C3"])).to eq(2)
    expect(board.letters_to_ranges(["A1", "A1", "C1"])).to eq(2)
  end

  it 'can turn letters from cords into a valid range' do
    expect(board.letters_to_ranges(["B3", "C3", "D3"])).to eq(1)
    expect(board.letters_to_ranges(["A2", "B2", "C2"])).to eq(1)
    expect(board.letters_to_ranges(["A2", "A3", "A4"])).to eq(1)
    expect(board.letters_to_ranges(["D1", "D2", "D3"])).to eq(1)
  end

  it 'can turn numbers from cords into a valid range' do
    expect(board.cord_to_ranges(["A1", "B1", "C1"])).to eq(1)
    expect(board.cord_to_ranges(["A1", "A2", "A3"])).to eq(1)
  end

  it 'checks if letters are in order up' do
    expect(board.ascending_letters(["A1", "B1", "C1"])).to eq true
    expect(board.ascending_letters(["B1", "C1", "D1"])).to eq true
  end

  it 'checks if letters are in order down' do
    expect(board.descending_letters(["D1", "C1", "B1"])).to eq true
    expect(board.descending_letters(["C1", "B1", "A1"])).to eq true
  end

  it 'can validate the length is equal to coordinates' do
    expect(board.valid_placement?(cruiser, ["A1", "A2"])).to be(false)
    expect(board.valid_placement?(submarine, ["A2", "A3", "A4"])).to be(false)
    expect(board.valid_placement?(submarine, ["A1", "A2"])).to be(true)
    expect(board.valid_placement?(cruiser, ["A2", "A3", "A4"])).to be(true)
  end

  it 'can check coordinates are consecutive' do
    expect(board.valid_placement?(cruiser, ["A1", "A2", "A4"])).to be(false)
    expect(board.valid_placement?(submarine, ["A1", "C1"])).to be(false)
    expect(board.valid_placement?(cruiser, ["A3", "A2", "A1"])).to be(false)
    expect(board.valid_placement?(submarine, ["C1", "B1"])).to be(false)
    expect(board.valid_placement?(submarine, ["B2", "B2", "D2"])).to be(false)
    expect(board.valid_placement?(submarine, ["A3", "C3", "C3"])).to be(false)
    expect(board.valid_placement?(submarine, ["A1", "A1", "A1"])).to be(false)
  end

  it 'cannot place ships diagonally' do
    expect(board.valid_placement?(cruiser, ["A1", "B2", "C3"])).to be(false)
    expect(board.valid_placement?(submarine, ["C2", "D3"])).to be(false)
    expect(board.valid_placement?(cruiser, ["A1", "B1", "A3"])).to be(false)
    expect(board.valid_placement?(cruiser, ["A1", "A1", "A3"])).to be(false)
  end

  it 'can validate possible ship placements' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    expect(board.valid_placement?(cruiser, ["A1", "A3"])).to be(false)
    expect(board.valid_placement?(cruiser, ["A1", "B2"])).to be(false)
    expect(board.valid_placement?(cruiser, ["B1", "C1", "D1"])).to be(true)
    expect(board.valid_placement?(submarine, ["A1", "A2"])).to be(true)
    expect(board.valid_placement?(cruiser, ["A1", "A2", "A3"])).to be(true)
  end
end

RSpec.describe Board do
  before(:each) do
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @board.place(@cruiser, ["A1", "A2", "A3"])
  end

  describe '#place' do
    it 'puts ship on board' do
      cell_1 = @board.cells["A1"]
      cell_2 = @board.cells["A2"]
      cell_3 = @board.cells["A3"]

      expect(@board.cells["A1"].ship).to eq(@cruiser)

      expect(@board.cells["A2"].ship).to eq(@cruiser)

      expect(@board.cells["A3"].ship).to eq(@cruiser)

      expect(cell_3.ship).to eq(cell_1.ship)
    end
  end

  describe '#overlapping ships' do
    it 'checks if coordinates have ship' do
      expect(@board.overlapping_ships(["A1", "B1", "C1"])).to eq true
      expect(@board.overlapping_ships(["B2", "B3", "B4"])).to eq false
    end

    it 'verifies no cell can hold two ships' do
      submarine = Ship.new("Submarine", 2)

      expect(@board.cells["A1"].empty?).to eq false
      expect(@board.valid_placement?(submarine, ["A1", "B1"])).to be false
    end
  end

  describe '#render' do

    it 'prints board to terminal' do
      expect(@board.render).to eq("  1 2 3 4\nA . . . .\nB . . . .\nC . . . .\nD . . . .\n")
    end

    it 'shows which cells contain a ship' do
      expect(@board.render(true)).to eq("  1 2 3 4\nA S S S .\nB . . . .\nC . . . .\nD . . . .\n")
    end

    it 'shows a cell with a miss' do
      cell_1 = @board.cells["C3"]
      cell_1.fire_upon

        expect(@board.render).to eq("  1 2 3 4\nA . . . .\nB . . . .\nC . . M .\nD . . . .\n")
    end

    it 'shows a cell with a hit' do
      cell_1 = @board.cells["A1"]
      cell_1.fire_upon

        expect(@board.render).to eq("  1 2 3 4\nA H . . .\nB . . . .\nC . . . .\nD . . . .\n")
    end

    it 'shows a ship that has been sunk' do # Need to turn all linked cells to X when a ship sinks.
      @cruiser.hit
      @cruiser.hit
      cell_1 = @board.cells["A1"]
      cell_1.fire_upon

      expect(@board.render).to eq("  1 2 3 4\nA X . . .\nB . . . .\nC . . . .\nD . . . .\n")
    end

    it 'shows submarine placement' do
      submarine = Ship.new("Submarine", 2)
      @board.place(submarine, ["B1", "C1"])
      expect(@board.render(true)).to eq("  1 2 3 4\nA S S S .\nB S . . .\nC S . . .\nD . . . .\n")
    end
  end
end
