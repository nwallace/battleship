class Battleship

  def self.battle(config_file)
    config_data = YAML.load_file(config_file)
    ConfigurationValidator.validate(config_data)
    board_size = config_data["board_size"]
    players_data = config_data["players"]
    players = players_data.map do |player_data|
      construct_player(player_data, GuessBoard.new(board_size), board_size)
    end
    game = Game.new(players, Screen.new)
    game.play
  end

  private

  def self.construct_player(player_data, guess_board, board_size)
    name = player_data["name"]
    ship_board = construct_ship_board(player_data["ships"], board_size)
    Player.new(name, ship_board, guess_board)
  end

  def self.construct_ship_board(ships_data, size)
    ships = ships_data.map do |ship_data|
      type = ship_data["type"]
      starting_block = ship_data["start"]
      orientation = ship_data["orientation"]
      Ship.new(type, starting_block, orientation)
    end
    ShipBoard.new(ships, size)
  end
end
