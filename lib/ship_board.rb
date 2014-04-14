class ShipBoard < Board

  attr_reader :size, :occupied_blocks

  def initialize(ships, size)
    @ships = ships
    @size = size
    @occupied_blocks = {}
    validate_ship_configuration
  end

  def all_ships_sunk?
    ships.all?(&:sunk?)
  end

  def receive_strike_at(block)
    ships.each do |ship|
      if ship.receive_strike_at(block)
        return true
      end
    end
    false
  end

  private

  attr_reader :ships

  def validate_ship_configuration
    ships.each do |ship|
      ship.occupied_blocks.each do |block|
        if @occupied_blocks.has_key?(block)
          error_msg = "#{ship.type.capitalize} overlaps " +
                      "#{@occupied_blocks[block].type} on block #{block}"
          raise IllegalShipConfigurationError.new(error_msg)
        else
          @occupied_blocks[block] = ship
        end
      end
    end
  end
end

class IllegalShipConfigurationError < StandardError
end
