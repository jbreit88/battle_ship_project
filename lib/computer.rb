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

  def player_input
    $stdin.gets.chomp.upcase
  end

  def player_shot
    answer = player_input

    until @comp_board.cells.keys.include?(answer) && @comp_board.cells[answer].fired_upon? == false
      puts "#{"\e[32m#{"Not a valid selection, Please try again:"}\e[0m"}"
      answer = player_input
    end

    @comp_board.cells[answer].fire_upon
    if @comp_board.cells[answer].render == "\e[33m#{"M"}\e[0m"
      puts "#{answer} is a miss!"
    elsif @comp_board.cells[answer].render == "\e[31m#{"X"}\e[0m"
      puts "You sunk my #{@comp_board.cells[answer].ship.name}!"
    elsif @comp_board.cells[answer].render == "\e[32m#{"H"}\e[0m"
      puts "#{answer} is a hit!"
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
