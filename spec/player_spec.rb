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

  describe "#all_ships_sunk?" do
    it "returns true if all of the players ships are sunk" do
      ship_board = double
      player.stub(ship_board: ship_board)
      ship_board.should_receive(:all_ships_sunk?).and_return(true)
      expect(player.all_ships_sunk?).to be_true
    end

    it "returns false if any of the player's ships are not sunk" do
      ship_board = double
      player.stub(ship_board: ship_board)
      ship_board.should_receive(:all_ships_sunk?).and_return(false)
      expect(player.all_ships_sunk?).to be_false
    end
  end

  describe "#guess" do
    pending
  end

  describe "#receive_strike_at" do
    pending
  end
end
