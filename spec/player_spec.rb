require_relative "../lib/player"

describe Player do
  let(:name)        { "Bob" }
  let(:ship_board)  { double }
  let(:guess_board) { double }
  let(:player)      { Player.new(name, ship_board, guess_board) }

  describe "initialization" do
    it "takes the player's name, ship config, and guess board" do
      Player.new(name, ship_board, guess_board)
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
    it "gets a guess from the guess_board" do
      guess_board.should_receive(:get_guess).and_return(guess="A1")
      player.guess.should == guess
    end
  end

  describe "#receive_strike_at" do
    it "sends the strike to the ship_board" do
      ship_board.should_receive(:receive_strike_at).with(block="A1")
      player.receive_strike_at(block)
    end
  end
end
