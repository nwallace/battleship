require "yaml"
require_relative "../lib/battleship"

class Player; end
class Ship; end
class Board; end
class ShipBoard < Board; end
class GuessBoard < Board; end
class Game; end

describe Battleship do

  describe ".battle" do
    let(:config_file) { "spec/fake_config.yml" }

    it "initializes the players from the config data and starts the game" do
      expect(Ship).to receive(:new).with("destroyer", "A1", "horizontal")
        .and_return(ship_1=double)
      expect(ShipBoard).to receive(:new).with([ship_1])
        .and_return(ship_config_1=double)
      expect(GuessBoard).to receive(:new)
        .and_return(board_1=double)
      expect(Player).to receive(:new).with("Bob", ship_config_1, board_1)
        .and_return(player_1=double)
      expect(Game).to receive(:new).with([player_1])
        .and_return(double(start: nil))
      Battleship.battle(config_file)
    end
  end
end
