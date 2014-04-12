require_relative "../lib/ship"

describe Ship do
  let(:type)        { "destroyer" }
  let(:block)       { "A1" }
  let(:orientation) { "horizontal" }
  let(:ship)        { Ship.new(type, block, orientation) }

  describe "initialization" do
    it "takes the name, starting block, and orientation" do
      Ship.new("destroyer", "A1", "horizontal")
    end

    it "raises IllegalShipConfigurationError if type is invalid" do
      Ship::SHIP_TYPES.keys.each { |t| Ship.new(t, block, orientation) }
      expect do
        Ship.new("invalid", block, orientation)
      end.to raise_error IllegalShipConfigurationError
    end

    it "raises IllegalShipConfigurationError if starting_block is invalid" do
      Ship.new(type, "A1", orientation)
      expect do
        Ship.new(type, "1A", orientation)
      end.to raise_error IllegalShipConfigurationError
    end

    it "raises IllegalShipConfigurationError if orientation is invalid" do
      Ship::SHIP_ORIENTATIONS.each { |o| Ship.new(type, block, o) }
      expect do
        Ship.new(type, block, "invalid")
      end.to raise_error IllegalShipConfigurationError
    end
  end

  describe "#type" do
    it "returns the type of the ship" do
      ship.type.should == "destroyer"
    end
  end

  describe "#occupied_blocks" do
    context "with horizontal orientation" do
      it "returns the array of the ship's occupied blocks" do
        ship = Ship.new("patrol boat", "A1", "horizontal")
        expect(ship.occupied_blocks).to match_array ["A1", "A2"]
      end
    end

    context "with vertical orientation" do
      it "returns the array of the ship's occupied blocks" do
        ship = Ship.new("patrol boat", "A1", "vertical")
        expect(ship.occupied_blocks).to match_array ["A1", "B1"]
      end
    end
  end
end
