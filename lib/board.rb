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
    return false if overlapping_ships(cords) == true

    if descending_letters(cords) || descending_numbers(cords)
      false
    elsif ascending_letters(cords) && ascending_numbers(cords)
      false
    elsif ascending_letters(cords) == false && single_letter(cords) == false
      false
    elsif ascending_numbers(cords) == false && single_number(cords) == false
      false
    elsif cord_to_ranges(cords) > 1 || letters_to_ranges(cords) > 1
      false
    elsif ascending_letters(cords) && single_number(cords)
      true
    elsif ascending_numbers(cords) && single_letter(cords)
      true
    end
  end

  def overlapping_ships(cords) # This breaks if use number outside range. # Pass ship and coord
    cords.any? {|cord| @cells[cord].empty? == false} # try .ship? instead of .empty? #def contain_ship?(ship, coord)
  end

  def place(ship, coordinates)
    if valid_placement?(ship, coordinates)
      coordinates.map { |coordinate| @cells[coordinate].place_ship(ship)}
    end
  end

  def cords_to_integers(cords) #deletes letters from coordiantes, returns cords of integers
    integers = []
    cords.each do |cord|
      integers << cord.slice(1).to_i
    end
    integers
  end

  def cord_letters_to_integers(cords) #deletes integers from coordinates, returns cords of .ord
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

  def cord_to_ranges(cords)
    numbers = cords_to_integers(cords)
    numbers.compact.uniq.sort
    ranges = []
    if !numbers.empty?
      left, right = numbers.first, nil
      numbers.each do |num|
        if right && num != right.succ
          ranges << Range.new(left,right)
          left = num
        end
        right = num
      end
      ranges << Range.new(left,right)
    end
    ranges.uniq.length
  end

  def letters_to_ranges(cords)
    letters = cord_letters_to_integers(cords)
    letters.compact.uniq.sort
    ranges = []
    if !letters.empty?
      left, right = letters.first, nil
      letters.each do |let|
        if right && let != right.succ
          ranges << Range.new(left,right)
          left = let
        end
        right = let
      end
      ranges << Range.new(left,right)
    end
    ranges.uniq.length
  end

  def place(ship, coordinates)
    if valid_placement?(ship, coordinates)
      coordinates.map { |coordinate| @cells[coordinate].place_ship(ship)}
    end
  end

  def render(arg = false)
    if arg == false
      board_render = "  1 2 3 4\n"  +
      "A #{@cells["A1"].render(arg)} #{@cells["A2"].render(arg)} #{@cells["A3"].render(arg)} #{@cells["A4"].render(arg)}\n" +
      "B #{@cells["B1"].render(arg)} #{@cells["B2"].render(arg)} #{@cells["B3"].render(arg)} #{@cells["B4"].render(arg)}\n" +
      "C #{@cells["C1"].render(arg)} #{@cells["C2"].render(arg)} #{@cells["C3"].render(arg)} #{@cells["C4"].render(arg)}\n" +
      "D #{@cells["D1"].render(arg)} #{@cells["D2"].render(arg)} #{@cells["D3"].render(arg)} #{@cells["D4"].render(arg)}\n"
    elsif arg == true
      board_render =  "  1 2 3 4\n" +
      "A #{@cells["A1"].render(arg)} #{@cells["A2"].render(arg)} #{@cells["A3"].render(arg)} #{@cells["A4"].render(arg)}\n" +
      "B #{@cells["B1"].render(arg)} #{@cells["B2"].render(arg)} #{@cells["B3"].render(arg)} #{@cells["B4"].render(arg)}\n" +
      "C #{@cells["C1"].render(arg)} #{@cells["C2"].render(arg)} #{@cells["C3"].render(arg)} #{@cells["C4"].render(arg)}\n" +
      "D #{@cells["D1"].render(arg)} #{@cells["D2"].render(arg)} #{@cells["D3"].render(arg)} #{@cells["D4"].render(arg)}\n"
    end
    board_render
  end
end
