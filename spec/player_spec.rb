require_relative "../lib/player"

describe Player do

  describe "initialization" do
    it "takes the player's name and stores it" do
      Player.new("bob").name.should == "bob"
    end
  end
end
