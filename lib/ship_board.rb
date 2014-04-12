class ShipBoard < Board

  def initialize(ships)
    @ships = ships
    validate_ship_configuration
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