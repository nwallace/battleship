require_relative "../lib/game"

describe Game do

  let(:board) { double }
  let(:player_1) { double }
  let(:player_2) { double }
  let(:game) { Game.new(board, player_1, player_2) }

  describe "initialization" do
    it "takes the board and two players" do
      board, player_1, player_2 = double, double, double
      expect do
        Game.new(board, player_1, player_2)
      end.not_to raise_error
    end
  end

  describe "#start" do
    it "starts the game" do
      game.should_receive(:turn_for).with(player_1)
      game.start
    end
  end

  describe "#turn_for" do
    before do
      player_1.stub(:guess)
      board.stub(:display_for)
    end

    it "renders the game board for the given player" do
      board.should_receive(:display_for).with(player_1)
      game.turn_for(player_1)
    end

    it "gets the next guess from the player" do
      player_1.should_receive(:guess)
      game.turn_for(player_1)
    end
  end
end
