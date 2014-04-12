class ConfigurationError < StandardError
end

class ConfigurationValidator

  def self.validate(config)
    validate_board_size(config)
    validate_players(config)
    validate_each_player(config)
    validate_each_ship(config)
  rescue KeyError => e
    raise_config_error(e.message)
  end

  private

  def self.raise_config_error(message)
    raise ConfigurationError.new(message)
  end

  def self.validate_board_size(config)
    board_size = config.fetch("board_size")
    unless board_size.is_a?(Integer)
      raise_config_error "board_size must be an integer"
    end
    unless board_size.between?(2, 26)
      raise_config_error "board_size.must be between 2 and 26"
    end
  end

  def self.validate_players(config)
    players = config.fetch("players")

    raise_config_error "there must be two players" unless players.size == 2
  end

  def self.validate_each_player(config)
    config["players"].each { |player| validate_player(player) }
  end

  def self.validate_player(config)
    raise_config_error "player must be a hash" unless config.is_a?(Hash)
    config.fetch("name")
    unless config.fetch("ships").is_a?(Array)
      raise_config_error "player ships must be an array"
    end
  end

  def self.validate_each_ship(config)
    config["players"].each do |player_config|
      player_config["ships"].each do |ship|
        raise_config_error "ship must be a hash" unless ship.is_a?(Hash)
        unless ship.fetch("start") =~ /\A[A-Z][0-9]+\Z/
          raise_config_error "invalid starting block #{ship["start"]}"
        end
        unless Ship::SHIP_TYPES.keys.include?(ship.fetch("type"))
          raise_config_error "#{ship["type"]} is not a valid ship type"
        end
        unless Ship::SHIP_ORIENTATIONS.include?(ship.fetch("orientation"))
          raise_config_error "#{ship["orientation"]} is not a valid ship orientation"
        end
        validate_ship_position(ship["start"], ship["orientation"],
                             Ship::SHIP_TYPES[ship["type"]], config["board_size"])
      end
    end
  end

  def self.validate_ship_position(start, orientation, ship_size, board_size)
    start_row = start[0].ord - 64 # "A".ord == 65
    start_col = start[1].to_i
    if orientation == "horizontal"
      end_row = start_row + ship_size - 1
      end_col = start_col
    else
      end_row = start_row
      end_col = start_col + ship_size - 1
    end
    unless [start_row, start_col, end_row, end_col].all? {|i| i <= board_size}
      raise_config_error "ship at #{start} does not fit on board"
    end
  end
end
