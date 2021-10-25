require './lib/board'
require "./lib/ship"
require "./lib/cell"

class Player

  attr_reader :cruiser,
              :submarine,
              :player_board
  def initialize
    @player_board = Board.new
    @player_cruiser = Ship.new("Cruiser", 3)
    @player_submarine = Ship.new("Submarine", 2)
  end

  def player_ship_place
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long."
    puts "  1 2 3 4\nA . . . .\nB . . . .\nC . . . .\nD . . . .\n"
    puts "Enter the squares for the Cruiser (3 spaces):"
    player_input = gets.chomp.to_s.upcase.split

    loop do
      if @player_board.valid_placement?(@player_cruiser, player_input) == false
        puts "Those are invalid coordinates. Please try again:"
        player_input = gets.chomp.to_s.upcase.split
      elsif @player_board.valid_placement?(@player_cruiser, player_input)
        @player_board.place(@player_cruiser, player_input)
        puts "You placed your ship at #{player_input}."
        puts "#{@player_board.render(true)}"
        break
      end
    end

    puts "Enter the squares for the Submarine (2 spaces):"
    player_input_2 = gets.chomp.to_s.upcase.split

    loop do
      if @player_board.valid_placement?(@player_submarine, player_input_2) == false
        puts "Those are invalid coordinates. Please try again:"
        player_input_2 = gets.chomp.to_s.upcase.split
      elsif @player_board.valid_placement?(@player_submarine, player_input_2)
        @player_board.place(@player_submarine, player_input_2)
        puts "You placed your ship at #{player_input_2}."
        puts "#{@player_board.render(true)}"
        break
      end
    end

  def comp_shot
    coordinate = @player_board.cells.keys.sample

    until @player_board.cells[coordinate].fired_upon? == false
      coordinate = @player_board.cells.keys.sample
    end

    if @player_board.cells[coordinate].fired_upon? == false
      @player_board.cells[coordinate].fire_upon
      puts "The computer fired at cell #{coordinate}."
    end

    if @player_board.cells[coordinate].render == "M"
      puts "#{coordinate} is a miss!"
    elsif @player_board.cells[coordinate].render == "X"
      puts "You sunk my #{@player_board.cells[coordinate].ship.name}!"
    elsif @player_board.cells[coordinate].render == "H"
      puts "#{coordinate} is a hit!"
    end
  end

  def player_board_render
    @player_board.render(true)
  end
end
