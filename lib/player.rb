require './lib/board'
require "./lib/ship"
require "./lib/cell"

class Player

  attr_reader :player_cruiser,
              :player_submarine,
              :player_board

  def initialize
    @player_board = Board.new
    @player_cruiser = Ship.new("Cruiser", 3)
    @player_submarine = Ship.new("Submarine", 2)
  end

  def player_input_method
    $stdin.gets.chomp.to_s.upcase.split
  end

  def player_ship_place_cruiser
    player_input = player_input_method

    loop do
      if @player_board.valid_placement?(@player_cruiser, player_input) == false
        puts "#{"\e[32m#{"Those are invalid coordinates. Please try again:"}\e[0m"}"
        player_input = player_input_method
      elsif @player_board.valid_placement?(@player_cruiser, player_input)
        @player_board.place(@player_cruiser, player_input)
        puts "You placed your ship at #{player_input}."
        sleep(1.5)
        puts "#{@player_board.render(true)}"
        break
      end
    end
  end

  def player_ship_place_submarine
    player_input_2 = player_input_method
    loop do
      if @player_board.valid_placement?(@player_submarine, player_input_2) == false
        puts “Those are invalid coordinates. Please try again:”
        player_input_2 = player_input_method
      elsif @player_board.valid_placement?(@player_submarine, player_input_2)
        @player_board.place(@player_submarine, player_input_2)
        puts "You placed your ship at #{player_input_2}."
        sleep(1.5)
        break
      end
    end
  end

  def computer_input
    @player_board.cells.keys.sample
  end

  def comp_shot
    coordinate = computer_input

    until @player_board.cells[coordinate].fired_upon? == false
      coordinate = computer_input
    end

    if @player_board.cells[coordinate].fired_upon? == false
      @player_board.cells[coordinate].fire_upon
      puts "The computer fired at cell #{coordinate}."
      sleep(1.5)
    end

    if @player_board.cells[coordinate].render == "\e[33m#{"M"}\e[0m"
      puts "#{coordinate} is a miss!"
    elsif @player_board.cells[coordinate].render == "\e[31m#{"X"}\e[0m"
      puts "You sunk my #{@player_board.cells[coordinate].ship.name}!"
    elsif @player_board.cells[coordinate].render == "\e[32m#{"H"}\e[0m"
      puts "#{coordinate} is a hit!"
    end
    return coordinate
  end

  def player_board_render
    @player_board.render(true)
  end

  def all_sunk?
    all_sunk = nil
    if @player_cruiser.sunk? == true && @player_submarine.sunk? == true
      all_sunk = true
    else
      all_sunk = false
    end
  end
end
