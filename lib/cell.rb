class Cell

  attr_reader :coordinate, :ship

  def initialize(coordinate)

    @coordinate = coordinate
    @empty = true
  end

  def ship
    @ship
  end

  def empty?
    @empty
  end

  def place_ship(ship_name, ship_length)


  end


end
