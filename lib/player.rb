class Player

  attr_reader :name

  def initialize(name, ship_configuration, guess_board)
    @name = name
    @ship_configuration = ship_configuration
    @guess_board = guess_board
  end
end
