require "yaml"
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

class Battleship

  def self.battle
    players_config = YAML.load_file("config.yml")
    player_1_config = players_config.fetch("player_1")
    player_2_config = players_config.fetch("player_2")
    player_1_ships = construct_ships_for_player(player_1_config)
    player_2_ships = construct_ships_for_player(player_2_config)
    board_1 = Board.new(player_1_ships)
    board_2 = Board.new(player_2_ships)
    player_1 = Player.new(player_1_config.fetch("name"), board_1)
    player_2 = Player.new(player_2_config.fetch("name"), board_2)
    game = Game.new(player_1, player_2)
    game.start
  end

  private

  def self.construct_ships_for_player(config)
    config.fetch("ships").map do |ship_config|
      Ship.new(ship_config.fetch("start"), ship_config.fetch("end"))
    end
  end
end

Battleship.battle
