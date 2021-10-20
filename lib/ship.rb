class Ship

  attr_reader :name, :length, :health

  def initialize(name, length)

    @name = name
    @length = length
    @health = length
    @sunk = false
  end

  def sunk?
    if @health > 0
      @sunk = false
    elsif @health == 0
      @sunk = true
    elsif @health < 0
      @sunk = true
    end
  end

  def hit # make not reduce below zero
    if @health > 0
      @health -= 1
    end
  end




end
