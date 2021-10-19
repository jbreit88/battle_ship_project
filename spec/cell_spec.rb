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
        expect(@cell.fired_upon?).to be false
    end
  end

end
