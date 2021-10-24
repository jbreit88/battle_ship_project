require "./lib/ship"
require "./lib/cell"
require "./lib/board"
require "./lib/game_play"

class Computer
  attr_reader :cruiser,
              :submarine,
              :comp_board

  def initialize
    @comp_board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  def comp_ship_place
    loop do
    cruiser_cords = []
    until cruiser_cords.length == @cruiser.length do
        cruiser_cords << @comp_board.cells.keys.sample
      end

      if @comp_board.valid_placement?(@cruiser, cruiser_cords)
        @comp_board.place(@cruiser, cruiser_cords)
        break
      end
    end
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
  end

  def cpu_display_board
  end

  def computer_shot
  end

  def results
  end
end
