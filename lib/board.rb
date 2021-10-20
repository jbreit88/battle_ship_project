class Board
  attr_reader :cells

  def initialize
    @cells = {
     "A1" => Cell.new("A1"),
     "A2" => Cell.new("A2"),
     "A3" => Cell.new("A3"),
     "A4" => Cell.new("A4"),
     "B1" => Cell.new("B1"),
     "B2" => Cell.new("B2"),
     "B3" => Cell.new("B3"),
     "B4" => Cell.new("B4"),
     "C1" => Cell.new("C1"),
     "C2" => Cell.new("C2"),
     "C3" => Cell.new("C3"),
     "C4" => Cell.new("C4"),
     "D1" => Cell.new("D1"),
     "D2" => Cell.new("D2"),
     "D3" => Cell.new("D3"),
     "D4" => Cell.new("D4")
    }
  end

  def valid_coordinate?(coordinate)
    @cells.keys.include?(coordinate)
  end

  def numbers_consecutive_up?(coordinates)
    numbers = []
    coordinates.each_with_index do |item, index|
      if (index %2 == 1)
        numbers << item
      end
    end
    numbers.map(&:to_i).each_cons(2).all? {|a, b| b == a + 1 }# returns boolean value
  end

  def numbers_consecutive_down?(coordinates)
    numbers = []
    coordinates.each_with_index do |item, index|
      if (index %2 == 1)
        numbers << item
      end
    end
    # require "pry"; binding.pry
    numbers.map(&:to_i).each_cons(2).all? {|a, b| b == a - 1 }# returns boolean value
  end
  #.slice(1).to_i
  #.slice(0).ord also gives integer for number
  def letters_consecutive?(coordinates)
    letters = []
    coordinates.each_with_index do |item, index|
      if (index %2 == 0)
        letters << item
      end
    end
    letters.map(&:to_i).each_cons(2).all? {|a, b| b == a + 1 }
  end

  def valid_placement?(ship, coordinates)
    up = numbers_consecutive_up?(coordinates)
    down = numbers_consecutive_down?(coordinates)
    coordinates.length == ship.length && up == false  #down == true inverted coordinates should pass
  end
end
#ceck consecutive letters if ship is placed veritcally
#check consecutive numbers if ship is placed laterally

def cords_to_letters(cords)
  letters = []
  cords.each do |cord|
    letters << cord.slice(0).ord
  end
  letters
end

def cords_to_integers(cords)
  integers = []
  cords.each do |cord|
    integers << cord.slice(1).to_i
  end
  integers
end

def ascending_letters
  letter_list = cords_to_letters(cords)
  if letter_list.first + (letter_list.length - 1) != letter_list.last
    false
  end
end

def descending_letters
  letter_list = cords_to_letters(cords)
  if letter_list.first - (letter_list.length + 1) != letter_list.last
    false
  end
end
