require_relative "../lib/board"
require_relative "../lib/ship_board"

describe ShipBoard do
  let(:ship) { double(type: "A", occupied_blocks: ["A1"]) }

  describe "initialization" do
    it "takes a list of ships" do
      expect do
        described_class.new([])
      end.not_to raise_error
    end

    it "raises IllegalConfigurationError if ships overlap" do
      ships = [double(type: "A", occupied_blocks: ["A1"]),
               double(type: "B", occupied_blocks: ["A1"])]
      expect do
        described_class.new(ships)
      end.to raise_error IllegalShipConfigurationError
    end
  end

  describe "#all_ships_sunk?" do
    it "returns true if all of the board's ships are sunk" do
      ship.stub(sunk?: true)
      ships = [ship]
      expect(described_class.new(ships).all_ships_sunk?).to be_true
    end

    it "returns false if any of the board's ships are not sunk" do
      ship.stub(sunk?: false)
      ships = [ship]
      expect(described_class.new(ships).all_ships_sunk?).to be_false
    end
  end

  describe "#receive_strike_at" do
    it "sends the strike to the board's ships" do
      ship.should_receive(:receive_strike_at).with(block="A1")
      ship_board = ShipBoard.new([ship])
      ship_board.receive_strike_at(block)
    end
  end
end
