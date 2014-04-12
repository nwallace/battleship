class Ship

  SHIP_ORIENTATIONS = ["horizontal", "vertical"]
  SHIP_TYPES = {
    "carrier" => 5,
    "battleship" => 4,
    "submarine" => 3,
    "destroyer" => 3,
    "patrol boat" => 2,
  }

  attr_reader :type, :occupied_blocks

  def initialize(type, starting_block, orientation)
    validate_initialization_values(type, starting_block, orientation)
    @type = type
    @occupied_blocks = []
    occupy_blocks(starting_block, orientation)
  end

  private

  def validate_initialization_values(type, starting_block, orientation)
    unless SHIP_TYPES.include?(type)
      error_msg = "Unknown ship type #{type}"
      raise IllegalShipConfigurationError.new(error_msg)
    end
    unless starting_block =~ /\A[A-Z][0-9][0-9]?\Z/
      error_msg = "Unknown starting block #{starting_block}"
      raise IllegalShipConfigurationError.new(error_msg)
    end
    unless SHIP_ORIENTATIONS.include?(orientation)
      error_msg = "Unknown orientation #{orientation}"
      raise IllegalShipConfigurationError.new(error_msg)
    end
  end

  def occupy_blocks(starting_block, orientation)
    next_block = starting_block
    SHIP_TYPES[type].times do
      occupied_blocks << next_block
      next_block = send("next_block_#{orientation}ly", next_block)
    end
  end

  def next_block_horizontally(starting_block)
    starting_block[0] + starting_block[1].next
  end

  def next_block_vertically(starting_block)
    starting_block[0].next + starting_block[1]
  end
end

class IllegalShipConfigurationError < StandardError
end
