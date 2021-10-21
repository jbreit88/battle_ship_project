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

  def valid_placement?(ship, cords)
    return false if cords.length != ship.length

    if descending_letters(cords) == true || descending_numbers(cords) == true
      false
    elsif ascending_letters(cords) == true && ascending_numbers(cords) == true
      false
    elsif ascending_letters(cords) == false && single_letter(cords) == false
      false
    elsif ascending_numbers(cords) == false && single_number(cords) == false
      false
    elsif ascending_letters(cords) == true && single_number(cords) == true
      true
    elsif ascending_numbers(cords) == true && single_letter(cords) == true
      true
    end
  end

  def cords_to_integers(cords) #deletes letters from coordiantes, returns array of integers
    integers = []
    cords.each do |cord|
      integers << cord.slice(1).to_i
    end
    integers
  end

  def cord_letters_to_integers(cords) #deletes integers from coordinates, returns array of .ord
    letters = []
    cords.each do |cord|
      letters << cord.slice(0).ord
    end
    letters
  end

  def single_letter(cords)
    cord_letters_to_integers(cords).uniq.length == 1
  end

  def single_number(cords)
    cords_to_integers(cords).uniq.length == 1
  end

  def ascending_letters(cords) #check if letters are ascending in order
    letter_list = cord_letters_to_integers(cords)
    letter_list.first + (letter_list.length - 1) == letter_list.last
  end

  def descending_letters(cords)
    letter_list = cord_letters_to_integers(cords)
    letter_list.first - (letter_list.length - 1) == letter_list.last
  end

  def ascending_numbers(cords)
    number_list = cords_to_integers(cords)
    number_list.first + (number_list.length - 1) == number_list.last
  end

  def descending_numbers(cords)
    number_list = cords_to_integers(cords)
    number_list.first - (number_list.length - 1) == number_list.last
  end
end
