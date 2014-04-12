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
        expect(ship.occupied_blocks.to_a).to match_array ["A1", "A2"]
      end
    end

    context "with vertical orientation" do
      it "returns the array of the ship's occupied blocks" do
        ship = Ship.new("patrol boat", "A1", "vertical")
        expect(ship.occupied_blocks.to_a).to match_array ["A1", "B1"]
      end
    end
  end

  describe "#receive_strike_at" do
    it "marks the targeted block as hit, if it occupied the block" do
      ship.receive_strike_at(block)
      ship.hit_blocks.to_a.should match_array [block]
    end

    it "ignores the strike if it does not occupy the block" do
      ship.receive_strike_at("B2")
      ship.hit_blocks.should be_empty
    end
  end


  describe "#sunk?" do
    it "returns true if all of the ship's occupied blocks have been hit" do
      block_list = Set.new(["A1"])
      ship.stub(hit_blocks: block_list, occupied_blocks: block_list)
      ship.should be_sunk
    end

    it "returns false if any of the ship's occupied blocks have not been hit" do
      block_list = Set.new(["A1"])
      ship.stub(hit_blocks: Set.new, occupied_blocks: block_list)
      ship.should_not be_sunk
    end
  end
end
