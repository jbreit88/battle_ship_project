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
    expect(board.keys.length).to eq(16)
  end
end
