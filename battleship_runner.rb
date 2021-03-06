require "./lib/ship"
require "./lib/cell"
require "./lib/board"
require "./lib/computer"
require "./lib/game_play"
require "./lib/player"

def start
  loop do
    new_game = GamePlay.new
    new_game.game_menu
    new_game.computer_place_ships
    new_game.player_place_ships
    new_game.turn
    new_game.end_game
  end
end

start
