class Board

  attr_reader :player_1_ships, :player_2_ships

  def initialize(player_1_ships, player_2_ships)
    @player_1_ships = player_1_ships
    @player_2_ships = player_2_ships
  end
end
