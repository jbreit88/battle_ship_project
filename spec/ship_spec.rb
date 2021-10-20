require './lib/ship'

RSpec.describe Ship do
  before(:each) do
    @cruiser = Ship.new("Cruiser", 3)
  end

  describe '#initialize' do
    it 'creates instance of ship' do
      expect(@cruiser).to be_instance_of Ship
    end

    it "has name and length" do
      expect(@cruiser.length).to eq 3
      expect(@cruiser.name).to eq ('Cruiser')
    end

    it "has health the same as length" do

      expect(@cruiser.health).to eq 3
      expect(@cruiser.health).to eq(@cruiser.length)
    end
  end

  describe '#sunk?' do
    it 'is not yet sunk' do
      expect(@cruiser.sunk?).to be false
    end
  end

  describe '#hit' do
    it 'reduces health until sunk' do
      @cruiser.hit
      expect(@cruiser.health).to eq 2

      @cruiser.hit
      expect(@cruiser.health).to eq 1

      expect(@cruiser.sunk?).to eq false

      @cruiser.hit
      expect(@cruiser.health).to eq 0

      expect(@cruiser.sunk?).to eq true
    end
  end
end
