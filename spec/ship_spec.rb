require_relative "../lib/ship"

describe Ship do

  describe "initialization" do
    it "takes the start and end locations" do
      Ship.new("A1", "A2")
    end
  end
end
