class ShipBoard < Board

  def initialize(ships)
    @ships = ships
    validate_ship_configuration
  end

  def all_ships_sunk?
    ships.all?(&:sunk?)
  end

  def receive_strike_at(block)
    ships.each do |ship|
      ship.receive_strike_at(block)
    end
  end

  private

  attr_reader :ships

  def validate_ship_configuration
    occupied_blocks = {}
    ships.each do |ship|
      ship.occupied_blocks.each do |block|
        if occupied_blocks.has_key?(block)
          error_msg = "#{ship.type.capitalize} overlaps " +
                      "#{occupied_blocks[block].type} on block #{block}"
          raise IllegalShipConfigurationError.new(error_msg)
        else
          occupied_blocks[block] = ship
        end
      end
    end
  end
end

class IllegalShipConfigurationError < StandardError
end
