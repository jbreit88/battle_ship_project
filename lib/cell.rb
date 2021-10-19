class Cell

  attr_reader :coordinate, :ship, :fired_upon

  def initialize(coordinate)
    @coordinate = coordinate
    @empty = true
    @fired_upon = false
    @render = "."
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
    if fired_upon? == false && empty? == true
      @fired_upon = true
    elsif fired_upon? == false && empty? == false
      @ship.hit
      @fired_upon = true
    end
  end

  def render# default parameter? https://medium.com/podiihq/ruby-parameters-c178fdcd1f4e
    # if show_ship = true
    #   @render = S
    if fired_upon? == false
      @render
    elsif fired_upon? == true && empty? == true
      @render = "M"
    elsif fired_upon? == true && empty? == false
      @render = "H"
    elsif sunk? == true
      @render = "X"
    end
  end
end
