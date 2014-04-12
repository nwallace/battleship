class Battleship

  def self.battle(config_file)
    config_data = YAML.load_file(config_file)
    ConfigurationValidator.validate(config_data)
    board_size = config_data["board_size"]
    players_data = config_data["players"]
    players = players_data.map do |player_data|
      construct_player(player_data)
    end
    game = Game.new(players)
    game.play
  end

  private

  def self.construct_player(player_data)
    name = player_data["name"]
    ship_config = construct_ship_config(player_data["ships"])
    board = GuessBoard.new
    Player.new(name, ship_config, board)
  end

  def self.construct_ship_config(ships_data)
    ships = ships_data.map do |ship_data|
      type = ship_data["type"]
      starting_block = ship_data["start"]
      orientation = ship_data["orientation"]
      Ship.new(type, starting_block, orientation)
    end
    ShipBoard.new(ships)
  end
end
