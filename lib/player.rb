class Player

  attr_reader :cruiser,
              :submarine,
              :player_board

  def initialize
    @player_board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
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

    print @player_board.render
  end

  # def player_board_render_ship_location
  #   puts "Want to remember your ship placement? Y or N"
  #   answer = gets.chomp.downcase
  #
  #   until ["y", "n"].include?(answer)
  #     puts "Invalid input. Please try again:"
  #     answer = gets.chomp.downcase
  #   end
  # end
  #
  # if answer == "y"
  #   @player_board.render(true)
  # elsif answer == "n"
  #   @player_board.render
  # end

  def player_board_render
    @player_board.render
  end
end
