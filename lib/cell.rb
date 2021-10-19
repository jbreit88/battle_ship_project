class Cell

  attr_reader :coordinate, :ship, :fired_upon

  def initialize(coordinate)
    @coordinate = coordinate
    @empty = true
    @fired_upon = false
  end

  def ship
    @ship
  end

  def empty?
    @empty
  end

  def place_ship(ship_name)
    @ship = ship_name
    @empty = false
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon # Make sure it cannot be fired on more than once.
    if fired_upon? == false
      @ship.hit
      @fired_upon = true
    end
  end
end
