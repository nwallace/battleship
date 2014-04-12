class Player

  attr_reader :name

  def initialize(name, ship_board, guess_board)
    @name = name
    @ship_board = ship_board
    @guess_board = guess_board
  end

  def all_ships_sunk?
    ship_board.all_ships_sunk?
  end
end
