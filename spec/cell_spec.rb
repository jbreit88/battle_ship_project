require './lib/ship'
require './lib/cell'

RSpec.describe Cell do
  before(:each) do
    @cell = Cell.new("B4")
    @cruiser = Ship.new("Cruiser", 3)
  end

  describe '#initialize' do
    it 'creates instance' do
      expect(@cell).to be_instance_of Cell
    end

    it 'has positional coordinate' do
      expect(@cell.coordinate).to eq("B4")
    end
  end

  describe '#ship' do
    it 'has no ship' do
      expect(@cell.ship).to eq nil
    end
  end

  describe '#empty?' do
    it 'is empty' do
      expect(@cell.empty?).to be true
    end
  end
end

RSpec.describe Cell do
  before(:each) do
    @cell = Cell.new("B4")
    @cruiser = Ship.new("Cruiser", 3)
    @cell.place_ship(@cruiser)
  end

  describe '#place_ship' do
    it 'changes ship' do # Is this test written properly?
      expect(@cell.ship).to eq(@cruiser)
    end

    it 'fills cell' do
      expect(@cell.empty?).to be false
    end
  end

  describe '#fired_upon' do
    it 'returns default value false' do
        expect(@cell.fired_upon).to be false
    end
  end

  describe '#fire_upon' do
    it 'changes @fired_upon to true' do
      expect(@cell.fired_upon).to be false
      @cell.fire_upon
      expect(@cell.fired_upon).to be true
      @cell.fire_upon # Checks firing on same spot twice doesn't affect @fired_upon value.
      expect(@cell.fired_upon).to be true
    end

    it 'reduces ship health by 1' do
      expect(@cruiser.health).to be 3
      @cell.fire_upon
      expect(@cruiser.health).to be 2 # Interaction map says command cell.ship.health. In pry that works, but here it doesn't. Problem?
      @cell.fire_upon # Checks firing on same spot twice doesn't affect ship health.
      expect(@cruiser.health).to be 2
    end
  end

end
