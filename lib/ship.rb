require 'set'

class Ship

  SHIP_ORIENTATIONS = ["horizontal", "vertical"]
  SHIP_TYPES = {
    "patrol boat" => 2,
    "destroyer"   => 3,
    "submarine"   => 3,
    "battleship"  => 4,
    "carrier"     => 5,
  }

  attr_reader :type, :occupied_blocks, :hit_blocks

  def initialize(type, starting_block, orientation)
    @type = type
    @occupied_blocks = Set.new
    @hit_blocks = Set.new
    occupy_blocks(starting_block, orientation)
  end

  def sunk?
    (occupied_blocks - hit_blocks).empty?
  end

  def receive_strike_at(block)
    if occupies_block?(block)
      hit_blocks << block
    end
  end

  def occupies_block?(block)
    occupied_blocks.include?(block)
  end

  private

  def validate_initialization_values(type, starting_block, orientation)
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
