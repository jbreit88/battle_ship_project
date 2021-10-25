require './lib/board'
require "./lib/ship"
require "./lib/cell"

class Player

  attr_reader :player_cruiser,
              :player_submarine,
              :player_board

  def initialize
    @player_board = Board.new
    @player_cruiser = Ship.new("Cruiser", 3)
    @player_submarine = Ship.new("Submarine", 2)
  end

  def player_ship_place_cruiser
    player_input = gets.chomp.to_s.upcase.split
    loop do
      if player_input.all? { |cord| player_board.cells.include?(cord)} == false
        puts "Those are invalid coordinates. Please try again:"
        player_input = gets.chomp.to_s.upcase.split
      elsif @player_board.valid_placement?(@player_cruiser, player_input) == false
        puts "Those are invalid coordinates. Please try again:"
        player_input = gets.chomp.to_s.upcase.split
      elsif @player_board.valid_placement?(@player_cruiser, player_input)
        @player_board.place(@player_cruiser, player_input)
        puts "You placed your ship at #{player_input}."
        sleep(1.5)
        puts "#{@player_board.render(true)}"
        break
      end
    end
  end

  def player_ship_place_submarine
    player_input_2 = gets.chomp.to_s.upcase.split
    loop do
      if player_input_2.all? { |cord| player_board.cells.include?(cord)} == false
        puts "Those are invalid coordinates. Please try again:"
        player_input_2 = gets.chomp.to_s.upcase.split
      elsif @player_board.valid_placement?(@player_submarine, player_input_2) == false
        puts "Those are invalid coordinates. Please try again:"
        player_input_2 = gets.chomp.to_s.upcase.split
      elsif @player_board.valid_placement?(@player_submarine, player_input_2)
        @player_board.place(@player_submarine, player_input_2)
        puts "You placed your ship at #{player_input_2}."
        sleep(1.5)
        break
      end
    end
  end

  def comp_shot
    coordinate = @player_board.cells.keys.sample

    until @player_board.cells[coordinate].fired_upon? == false
      coordinate = @player_board.cells.keys.sample
    end

    if @player_board.cells[coordinate].fired_upon? == false
      @player_board.cells[coordinate].fire_upon
      puts "The computer fired at cell #{coordinate}."
      sleep(1.5)
    end

    if @player_board.cells[coordinate].render == "M"
      puts "#{coordinate} is a miss!"
    elsif @player_board.cells[coordinate].render == "X"
      puts "You sunk my #{@player_board.cells[coordinate].ship.name}!"
    elsif @player_board.cells[coordinate].render == "H"
      puts "#{coordinate} is a hit!"
    end
    return coordinate
  end

  def comp_shot_test(coord)
    if @player_board.cells[coord].fired_upon? == false
      @player_board.cells[coord].fire_upon
    end

    if @player_board.cells[coord].render == "M"
      return "#{coord} is a miss!"
    elsif @player_board.cells[coord].render == "X"
      return "You sunk my #{@player_board.cells[coord].ship.name}!"
    elsif @player_board.cells[coord].render == "H"
      return "#{coord} is a hit!"
    end
  end

  def player_board_render
    @player_board.render(true)
  end

  def all_sunk?
    all_sunk = nil
    if @player_cruiser.sunk? == true && @player_submarine.sunk? == true
      all_sunk = true
    else
      all_sunk = false
    end
  end
end
