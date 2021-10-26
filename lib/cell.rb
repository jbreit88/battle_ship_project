class Cell

  attr_reader :coordinate, :ship, :fired_upon

  def initialize(coordinate)
    @coordinate = coordinate
    @empty = true
    @fired_upon = false
    @render = "."
    @ship = nil
  end

  def empty?
    @empty
  end

  def place_ship(ship_name)
    @empty = false
    @ship = ship_name #no value returned in interaction pattern, but pry returns this.
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon # Make sure it cannot be fired on more than once.
    if fired_upon? == false && empty? == true
      @fired_upon = true #returns true in pry, can I fix this?
    elsif fired_upon? == false && empty? == false
      @fired_upon = true
      @ship.hit #returns ship health in pry, but interaction pattern has no return value.
    end
  end

  def render(show_ship=false)# default parameter? https://medium.com/podiihq/ruby-parameters-c178fdcd1f4e
    if show_ship == true && empty? == false && fired_upon? == false
        @render = "\e[34m#{"S"}\e[0m"
    elsif fired_upon? == false
      @render = "\e[35m#{"."}\e[0m"
    elsif fired_upon? == true && empty? == true
      @render = "\e[33m#{"M"}\e[0m"
    elsif @ship.sunk? == true || nil
      @render = "\e[31m#{"X"}\e[0m"
    elsif fired_upon? == true && empty? == false && @ship.sunk? == false
      @render = "\e[32m#{"H"}\e[0m"
    end
  end
end
