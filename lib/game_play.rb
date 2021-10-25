require './lib/ship'
require "./lib/board"
require './lib/cell'
require './lib/computer'
require './lib/player'

class GamePlay

  attr_accessor :computer,
              :player

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
    puts "Player ships placed!"
    sleep(2.0)
  end

  def turn
    until @player.all_sunk? == true || @computer.all_sunk? == true
      puts "These are the boards:"
      sleep(1.5)
      puts "#{"=" * 10} COMPUTER BOARD #{"=" * 10}"
      print @computer.cpu_display_board
      puts "#{"=" * 10} PLAYER BOARD #{"=" * 10}"
      print @player.player_board_render
      sleep(2.0)
      puts "Player shot. Input cell to be fired upon:"
      @computer.player_shot
      sleep(1.5)
      puts "Computer is choosing point of attack."
      sleep(1.5)
      @player.comp_shot
    end
  end

  def end_game
    if @computer.all_sunk? && @player.all_sunk?
      puts "Ending boards are:"
      puts "#{"=" * 10} COMPUTER BOARD #{"=" * 10}"
      print @computer.cpu_display_board
      puts "#{"=" * 10} PLAYER BOARD #{"=" * 10}"
      print @player.player_board_render
      sleep(1.5)
      puts "It's a draw. Would you like to play again? Y or N"
      player_input = gets.chomp.downcase

      until ["y", "n"].include?(player_input)
        puts "Not a valid selection, Please try again:"
        player_input = gets.chomp.downcase
      end

      if player_input == "y"
        puts "Let's try it again!"
      elsif player_input == "n"
        puts "Thank you for playing!"
        sleep(1.5)
        puts "Goodbye!"
        sleep(1.5)
        exit(true)
      end

    elsif @computer.all_sunk? && @player.all_sunk? == false
      puts "Ending boards are:"
      puts "#{"=" * 10} COMPUTER BOARD #{"=" * 10}"
      print @computer.cpu_display_board
      puts "#{"=" * 10} PLAYER BOARD #{"=" * 10}"
      print @player.player_board_render
      sleep(1.5)
      puts "Congrats! You showed that computer what for!"
      sleep(1.5)
      puts "Would you like to play again? Y or N"

      player_input = gets.chomp.downcase

      until ["y", "n"].include?(player_input)
        puts "Not a valid selection, Please try again:"
        player_input = gets.chomp.downcase
      end

      if player_input == "y"
        puts "Let's try it again!"
      elsif player_input == "n"
        puts "Thank you for playing!"
        sleep(1.5)
        puts "Goodbye!"
        sleep(1.5)
        exit(true)
      end


    elsif @player.all_sunk? && @computer.all_sunk? == false
      puts "Ending boards are:"
      puts "#{"=" * 10} COMPUTER BOARD #{"=" * 10}"
      print @computer.cpu_display_board
      puts "#{"=" * 10} PLAYER BOARD #{"=" * 10}"
      print @player.player_board_render
      sleep(1.5)
      puts "Looks like the computer took it this time."
      sleep(1.5)
      puts "Would you like to try again? Y or N"

      player_input = gets.chomp.downcase

      until ["y", "n"].include?(player_input)
        puts "Not a valid selection, Please try again:"
        player_input = gets.chomp.downcase
      end

      if player_input == "y"
        puts "Let's try it again!"
      elsif player_input == "n"
        puts "Thank you for playing!"
        sleep(1.0)
        puts "Goodbye!"
        sleep(1.5)
        exit(true)
      end
    end
  end
end
