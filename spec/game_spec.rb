require_relative "../lib/game"

describe Game do

  let(:players) { [double, double] }
  let(:game)    { described_class.new(players) }

  describe "initialization" do
    it "takes the list of players" do
      game = described_class.new(players)
      game.players.should == players
    end
  end

  describe "#play" do
    it "plays the game until the game is over" do
      game.should_receive(:game_over?).twice.and_return(false, false, true)
      game.should_receive(:turn_for).once.with(players[0])
      game.should_receive(:turn_for).once.with(players[1])
      game.play
    end
  end

  describe "player helpers" do
    it "#current_player returns the current player" do
      game.current_player.should == players[0]
    end

    it "#next_player returns the next player" do
      game.next_player.should == players[1]
    end

    it "#previous_player returns the previous player" do
      game.previous_player.should == players[1]
    end
  end

  describe "#game_over?" do
    it "returns false if current player's ships are not all sunk" do
      game.stub(current_player: double(all_ships_sunk?: false))
      game.should_not be_game_over
    end

    it "returns false if current player's ships are all sunk" do
      game.stub(current_player: double(all_ships_sunk?: true))
      game.should be_game_over
    end
  end
end
