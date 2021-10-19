class Board
  attr_reader :cells

  def initialize
    @cells = {
     "A1" => ("A1"),
     "A2" => ("A2"),
     "A3" => ("A3"),
     "A4" => ("A4"),
     "B1" => ("B1"),
     "B2" => ("B2"),
     "B3" => ("B3"),
     "B4" => ("B4"),
     "C1" => ("C1"),
     "C2" => ("C2"),
     "C3" => ("C3"),
     "C4" => ("C4"),
     "D1" => ("D1"),
     "D2" => ("D2"),
     "D3" => ("D3"),
     "D4" => ("D4")
    }
    #needs to have the cell class require so we can call Cell.new in hash?
  end
end
