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




end
