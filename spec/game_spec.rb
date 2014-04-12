require_relative "../lib/game"

describe Game do

  let(:players) { [] }
  let(:game)    { described_class.new(players) }

  describe "initialization" do
    it "takes the list of players" do
      described_class.new([])
    end
  end

  describe "#start" do
    it "starts the game" do
      game.start
    end
  end
end
