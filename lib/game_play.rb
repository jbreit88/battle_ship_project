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
  end

  def player_place_ships
    print "Please place your ships on the board."
  end

  def results

  end

  def end_game

  end
end
