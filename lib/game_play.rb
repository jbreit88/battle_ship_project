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
    puts "#{"\e[31m#{" ______       ______  _________  _________   |         ______   ______   |     |  _________    _______"}\e[0m"}"
    puts "#{"\e[33m#{"|      |     /     |      |          |       |        |        |         |     |      |       |      |"}\e[0m"}"
    puts "#{"\e[32m#{"|______|    /______|      |          |       |        |_____   |______   |_____|      |       |______|"}\e[0m"}"
    puts "#{"\e[34m#{"|      |   /       |      |          |       |        |               |  |     |      |       |"}\e[0m"}"
    puts "#{"\e[35m#{"|______|  /        |      |          |       |______  |______   ______|  |     |  ____|____   |"}\e[0m"}"
    puts "#{"\e[31m#{"_____________________"}\e[0m"}#{"\e[33m#{"_____________________"}\e[0m"}#{"\e[32m#{"_____________________"}\e[0m"}#{"\e[34m#{"_____________________"}\e[0m"}#{"\e[35m#{"_____________________"}\e[0m"}"

    puts "Enter #{"\e[34m#{"P"}\e[0m"} to play. Enter #{"\e[34m#{"Q"}\e[0m"} to quit."
    player_input = gets.chomp.downcase

    until ["p", "q"].include?(player_input)
      puts "#{"\e[32m#{"Not a valid selection, Please try again:"}\e[0m"}"
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
    # until @player.all_sunk? == true || @computer.all_sunk? == true
    loop do
      puts "These are the boards:"
      sleep(1.5)
      puts "#{"=" * 10} COMPUTER BOARD #{"=" * 10}"
      print @computer.cpu_display_board
      puts "#{"=" * 10} PLAYER BOARD #{"=" * 10}"
      print @player.player_board_render
      sleep(2.0)
      puts "Player shot. Input cell to be fired upon:"
      @computer.player_shot
      break if check_end_game?
      sleep(1.5)
      puts "Computer is choosing point of attack."
      sleep(1.5)
      @player.comp_shot
      break if check_end_game?
    end
  end

  def check_end_game?
    @computer.all_sunk? || @player.all_sunk?
  end

  def end_game
    if @computer.all_sunk? && @player.all_sunk? == false
      puts "Ending boards are:"
      puts "#{"=" * 10} COMPUTER BOARD #{"=" * 10}"
      print @computer.cpu_display_board
      puts "#{"=" * 10} PLAYER BOARD #{"=" * 10}"
      print @player.player_board_render
      sleep(1.5)
      puts "Congrats! You showed that computer what for!"
      sleep(1.5)
      puts "Would you like to play again? #{"\e[34m#{"Y"}\e[0m"} or #{"\e[34m#{"N"}\e[0m"}"

      player_input = gets.chomp.downcase

      until ["y", "n"].include?(player_input)
        puts "#{"\e[32m#{"Not a valid selection, Please try again:"}\e[0m"}"
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
      puts "Would you like to try again? #{"\e[34m#{"Y"}\e[0m"} or #{"\e[34m#{"N"}\e[0m"}"

      player_input = gets.chomp.downcase

      until ["y", "n"].include?(player_input)
        puts "#{"\e[32m#{"Not a valid selection, Please try again:"}\e[0m"}"
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
