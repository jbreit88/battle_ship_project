require './lib/board'
require "./lib/ship"
require "./lib/cell"
require "./lib/board"

class Player

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
        player_input
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
        player_input_2
        puts "#{@player_board.render(true)}"
        break
      end
    end
  end
end
