require './lib/ship'
require "./lib/board"
require './lib/cell'
require './lib/computer'
require './lib/player'

class GamePlay
  attr_reader :cruiser,
              :submarine,
              :comp_board

  def initialize
    @comp_board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @computer = Computer.new
    @player = Player.new
  end

  def game_menu
    puts "Welcome to...."
    sleep(1.5)
    puts " ______       ______  _________  _________   |         ______   ______   |     |  _________    _______"
    puts "|      |     /     |      |          |       |        |        |         |     |      |       |      |"
    puts "|______|    /______|      |          |       |        |_____   |______   |_____|      |       |______|"
    puts "|      |   /       |      |          |       |        |               |  |     |      |       |"
    puts "|______|  /        |      |          |       |______  |______   ______|  |     |  ____|____   |"
    puts "___________________________________________________________________________________________________________"

    puts "Enter p to play. Enter q to quit."
    player_input = gets.chomp.downcase

    until ["p", "q"].include?(player_input)
      puts "Not a valid selection, Please try again:"
      player_input = gets.chomp.downcase
    end

    if player_input == "p"
      puts "Game On!"
    elsif player_input == "q"
      puts "Thank you for playing!"
      sleep(1.0)
      puts "Goodbye!"
      sleep(1.5)
      exit(true)
    end
  end

  def computer_place_ships
    puts "The computer will now place their ships."
    @computer.comp_ship_place
    sleep(1.5)
    puts "Computer ship placement complete."
    print @computer.comp_board.render
  end

  def player_place_ships
    print "Please place your ships on the board."
  end
  # def build_game
  #   #Thinking we will need to put comp_place-ship and player_place_ship into the board.rb class
  #   #Call comp_place_ship and player_ship_place in this method.
  #   #need to find a way to randomize the coordinates and still adehre to valid placement method
  # end

  # def comp_ship_place
  #   loop do
  #   cruiser_cords = []
  #   until cruiser_cords.length == @cruiser.length do
  #       cruiser_cords << @comp_board.cells.keys.sample
  #     end
  #
  #     if @comp_board.valid_placement?(@cruiser, cruiser_cords)
  #       @comp_board.place(@cruiser, cruiser_cords)
  #       break
  #     end
  #   end
    #
    # loop do
    #   submarine_cords = []
    #   (cpu_submarine.length).times do
    #     submarine_cords << @comp_board.cells.keys.sample
    #   end
    #
    #   # if @comp_board.valid_placement?(cpu_cruiser, submarine_cords)
    #   if @comp_board.place(cpu_submarine, submarine_cords) != nil
    #     break
    #   end
    # end
  # end


  def results

  end

  def end_game

  end
end

# game = GamePlay.new
# game.game_menu
