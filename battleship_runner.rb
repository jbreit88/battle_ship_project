require "./lib/ship"
require "./lib/cell"
require "./lib/board"
#require "./lib/computer"
require "./lib/game_play"
#require "./lib/player"

def start
  new_game = GamePlay.new

  new_game.game_menu


end


start
