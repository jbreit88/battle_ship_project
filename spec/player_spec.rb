require "rspec"
require './lib/ship'
require "./lib/board"
require './lib/cell'
require './lib/computer'
require "./lib/player"

describe Player do
  let(:player) {Player.new}

  it 'exists' do
    expect(player).to be_an_instance_of(Player)
  end
end
