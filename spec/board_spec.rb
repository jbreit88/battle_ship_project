require "rspec"
require './lib/ship'
require "./lib/board"

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
  it '#cords to integers' do
    board = Board.new

    expect(board.cords_to_integers(["A1", "A2"])).to be_an(Array)
    expect(board.cords_to_integers(["A1", "A2"])).to eq([1, 2])
  end

  it '#cord_letters_to_integers' do
    board = Board.new

    expect(board.cord_letters_to_integers(["A1", "A2"])).to be_an(Array)
    expect(board.cord_letters_to_integers(["A1", "A2"])).to eq([65, 65])
  end

  it '#single_letter_use' do
    board = Board.new

    expect(board.single_letter(["A1", "A2"])).to eq(true)
    expect(board.single_letter(["A1", "B1"])).to eq(false)
  end

  describe '#single_number' do
    it 'checks if coordinates only have one numer for each value' do
      board = Board.new

      expect(board.single_number(["A1", "B1", "C1"])).to be true
      expect(board.single_number(["B1", "C1", "D1"])).to be true
    end
  end

  it '#ascending numbers' do
    board = Board.new

    expect(board.ascending_numbers(["A1", "A2", "A3"])).to be(true)
    expect(board.ascending_numbers(["A3", "A2", "A1"])).to be(false)
  end

  it '#descending numbers' do
    board = Board.new

    expect(board.descending_numbers(["A1", "A2", "A3"])).to be(false)
    expect(board.descending_numbers(["A3", "A2", "A1"])).to be(true)
  end

  describe '#ascending_letters' do
    it 'checks if letters are in order up' do
      board = Board.new

      expect(board.ascending_letters(["A1", "B1", "C1"])).to eq true
      expect(board.ascending_letters(["B1", "C1", "D1"])).to eq true
    end
  end

  describe '#descending_letters' do
    it 'checks if letters are in order down' do
      board = Board.new

      expect(board.descending_letters(["D1", "C1", "B1"])).to eq true
    end
  end

  it 'can validate the length is equal to coordinates' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    expect(board.valid_placement?(cruiser, ["A1", "A2"])).to be(false)
    expect(board.valid_placement?(submarine, ["A2", "A3", "A4"])).to be(false)
  end


  it 'can check coordinates are consecutive' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    expect(board.valid_placement?(cruiser, ["A1", "A2", "A4"])).to be(false)
    expect(board.valid_placement?(submarine, ["A1", "C1"])).to be(false)
    expect(board.valid_placement?(cruiser, ["A3", "A2", "A1"])).to be(false)
    expect(board.valid_placement?(submarine, ["C1", "B1"])).to be(false)
  end

  it 'cannot place ships diagonally' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    expect(board.valid_placement?(cruiser, ["A1", "B2", "C3"])).to be(false)
    expect(board.valid_placement?(submarine, ["C2", "D3"])).to be(false)
  end

  it 'can validate possible ship placements' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    expect(board.valid_placement?(cruiser, ["A1", "B2"])).to be(false)
    expect(board.valid_placement?(cruiser, ["B1", "C1", "D1"])).to be(true)
    expect(board.valid_placement?(submarine, ["A1", "A2"])).to be(true)
  end
end
