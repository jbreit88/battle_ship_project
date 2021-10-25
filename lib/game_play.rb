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
    sleep(1.5)
  end

  def player_place_ships
    puts "You now need to lay out your two ships."
    sleep(1.5)
    puts "The Cruiser is three units long and the Submarine is two units long."
    sleep(1.5)
    print @player.player_board.render
    puts "Enter your desired coordinates for the Cruiser (3 spaces):"
    @player.player_ship_place_cruiser
    sleep(1.5)
    puts "Enter your desired coordinates for the Submarine (2 spaces):"
    @player.player_ship_place_submarine
  end

  def turn
    until @player.all_sunk? == true || @computer.all_sunk? == true
      puts "#{"=" * 10} COMPUTER BOARD #{"=" * 10}"
      print @computer.cpu_display_board
      puts "#{"=" * 10} COMPUTER BOARD #{"=" * 10}"
      print @player.player_board_render # Make sure this is rendering ship locations AND all other information.
      sleep(1.5)
      puts "Player shot. Input cell to be fired upon:"
      @computer.player_shot

    end
  end

  def results

  end

  def end_game

  end
end
