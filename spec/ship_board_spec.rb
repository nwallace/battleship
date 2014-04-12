require_relative "../lib/board"
require_relative "../lib/ship_board"

describe ShipBoard do

  describe "initialization" do
    it "takes a list of ships" do
      expect do
        ShipBoard.new([])
      end.not_to raise_error
    end

    it "raises IllegalConfigurationError if ships overlap" do
      ships = [double(type: "A", occupied_blocks: ["A1"]),
               double(type: "B", occupied_blocks: ["A1"])]
      expect do
        ShipBoard.new(ships)
      end.to raise_error IllegalShipConfigurationError
    end
  end
end
