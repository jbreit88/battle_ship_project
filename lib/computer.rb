require "./lib/ship"
require "./lib/cell"
require "./lib/board"

class Computer
  attr_reader :comp_cruiser,
              :comp_submarine,
              :comp_board

  def initialize
    @comp_board = Board.new
    @comp_cruiser = Ship.new("Cruiser", 3)
    @comp_submarine = Ship.new("Submarine", 2)
  end

  def comp_ship_place
    loop do
    cruiser_cords = []
    until cruiser_cords.length == @comp_cruiser.length do
        cruiser_cords << @comp_board.cells.keys.sample
      end

      if @comp_board.valid_placement?(@comp_cruiser, cruiser_cords)
        @comp_board.place(@comp_cruiser, cruiser_cords)
        break
      end
    end

    loop do
    submarine_cords = []
    until submarine_cords.length == @comp_submarine.length do
        submarine_cords << @comp_board.cells.keys.sample
      end

      if @comp_board.valid_placement?(@comp_submarine, submarine_cords)
        @comp_board.place(@comp_submarine, submarine_cords)
        break
      end
    end
  end

  def cpu_display_board
    @comp_board.render
  end

  # def player_shot
  #   answer = $stdin.gets.chomp.upcase
  #
  #   until @comp_board.cells.keys.include?(answer) && @comp_board.cells[answer].fired_upon? == false
  #     puts "Not a valid selection, Please try again:"
  #     answer = $stdin.gets.chomp.upcase
  #   end
  #
  #   @comp_board.cells[answer].fire_upon
  #   if @comp_board.cells[answer].render == "M"
  #     puts "#{answer} is a miss!"
  #   elsif @comp_board.cells[answer].render == "X"
  #     puts "You sunk my #{@comp_board.cells[answer].ship.name}!"
  #   elsif @comp_board.cells[answer].render == "H"
  #     puts "#{answer} is a hit!"
  #   end
  #   print @comp_board.render
  # end

  def player_shot
    answer = $stdin.gets.chomp.upcase

    until @comp_board.cells.keys.include?(answer) && @comp_board.cells[answer].fired_upon? == false
      puts "Not a valid selection, Please try again:"
      answer = $stdin.gets.chomp.upcase
    end

    @comp_board.cells[answer].fire_upon
    if @comp_board.cells[answer].render == "M"
      puts "#{answer} is a miss!"
    elsif @comp_board.cells[answer].render == "X"
      puts "You sunk my #{@comp_board.cells[answer].ship.name}!"
    elsif @comp_board.cells[answer].render == "H"
      puts "#{answer} is a hit!"
    end
    print @comp_board.render
  end

  def player_shot_test(coord)

    until @comp_board.cells.keys.include?(coord) && @comp_board.cells[coord].fired_upon? == false
      puts "Not a valid selection, Please try again:"
      return "Not a valid selection, Please try again:"
    end

    @comp_board.cells[coord].fire_upon
    if @comp_board.cells[coord].render == "M"
      puts "#{coord} is a miss!"
    elsif @comp_board.cells[coord].render == "X"
      puts "You sunk my #{@comp_board.cells[coord].ship.name}!"
    elsif @comp_board.cells[coord].render == "H"
      puts "#{coord} is a hit!"
    end
    print @comp_board.render
  end

  def all_sunk?
    all_sunk = nil
    if @comp_cruiser.sunk? == true && @comp_submarine.sunk? == true
      all_sunk = true
    else
      all_sunk = false
    end
  end

end
