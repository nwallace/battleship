require_relative "../lib/player"

describe Player do
  let(:name)        { "Bob" }
  let(:ship_config) { double }
  let(:guess_board) { double }
  let(:player)      { Player.new(name, ship_config, guess_board) }

  describe "initialization" do
    it "takes the player's name, ship config, and guess board" do
      Player.new(name, ship_config, guess_board)
    end
  end

  describe "#name" do
    it "returns the player's name" do
      player.name.should == name
    end
  end
end
