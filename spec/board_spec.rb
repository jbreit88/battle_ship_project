require "rspec"
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
