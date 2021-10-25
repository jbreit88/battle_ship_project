require "./lib/ship"
require "./lib/cell"
require "./lib/board"
require "./lib/computer"
require "./lib/player"

class GamePlay
  
  def game_menu

     puts "Welcome to...."
     sleep(1.5)
     puts " ______       ______  _________  _________   |         ______   ______   |     |  _________    _______"
     puts "|      |     /     |      |          |       |        |        |         |     |      |       |       |"
     puts "|______|    /______|      |          |       |        |_____   |______   |_____|      |       |_______|"
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
       self.build_game
     elsif player_input == "q"
       puts "Thank you for playing!"
     end
   end

   def build_game
     #Thinking we will need to put comp_place-ship and player_place_ship into the board.rb class
     #Call comp_place_ship and player_ship_place in this method.
     #need to find a way to randomize the coordinates and still adehre to valid placement method
   end

  def comp_ship_place

  end

  def player_ship_place

  end

  def display_board

  end

  def player_shot

  end

  def computer_shot

  end

  def results


  end

  def end_game

  end

end

game = GamePlay.new
game.game_menu
