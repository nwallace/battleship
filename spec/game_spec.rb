require_relative "../lib/game"

describe Game do

  let(:screen)  { double }
  let(:players) { [double, double] }
  let(:game)    { described_class.new(players, screen) }

  describe "initialization" do
    it "takes the list of players and a screen" do
      game = described_class.new(players, screen)
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

  describe "#turn_for" do
    let(:player)      { double }
    let(:next_player) { double(receive_strike_at: nil) }

    before do
      screen.stub(:render_guess_for)
      player.stub(:guess)
      game.stub(next_player: next_player)
    end

    it "renders the guess view for the given player" do
      screen.should_receive(:render_guess_for).with(player)
      game.turn_for(player)
    end

    it "gets the guess from the given player" do
      player.should_receive(:guess)
      game.turn_for(player)
    end

    it "strikes the next_player at the guessed location" do
      player.should_receive(:guess).and_return("A1")
      next_player.should_receive(:receive_strike_at).with("A1")
      game.turn_for(player)
    end
  end
end
