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
