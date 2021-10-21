require "rspec"
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
  xit 'can validate the length is equal to coordinates' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    expect(board.valid_placement?(cruiser, ["A1", "A2"])).to be(false)
    expect(board.valid_placement?(submarine, ["A2", "A3", "A4"])).to be(false)
  end

  xit 'can check coordinates are consecutive' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    board.valid_placement?(cruiser, ["A1", "A2", "A4"])


    expect(board.valid_placement?(cruiser, ["A1", "A2", "A4"])).to be(false)
    expect(board.valid_placement?(submarine, ["A1", "C1"])).to be(false)
    expect(board.valid_placement?(cruiser, ["A3", "A2", "A1"])).to be(false)
    expect(board.valid_placement?(submarine, ["C1", "B1"])).to be(false)
  end

  xit 'cannot place ships diagonally' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    expect(board.valid_placement?(cruiser, ["A1", "B2", "C3"])).to be(false)
    expect(board.valid_placement?(submarine, ["C2", "D3"])).to be(false)
  end

  xit 'can validate possible ship placements' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    expect(board.valid_placement?(cruiser, ["B1", "C1", "D1"])).to be(true)
    expect(board.valid_placement?(submarine, ["A1", "A2"])).to be(true)
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
    xit 'verifies no cell can hold two ships' do
      submarine = Ship.new("Submarine", 2)
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
      
    end

    it 'shows a cell with a hit' do

    end

    it 'shows a ship that has been sunk' do

    end
  end
end
