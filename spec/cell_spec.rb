require './lib/ship'
require './lib/cell'

RSpec.describe Cell do
  before(:each) do
    @cell = Cell.new("B4")
  end

  describe '#initialize' do
    it 'creates instance' do
      expect(@cell).to be_instance_of Cell
    end

    it 'has positional coordinate' do
      expect(@cell.coordinate).to eq("B4")
    end


  end




end
