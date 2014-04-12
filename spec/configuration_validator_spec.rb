require_relative "../lib/ship"
require_relative "../lib/configuration_validator"

class Hash
  def except(*keys)
    reject { |key, val| keys.include? key }
  end
end

describe ConfigurationValidator do

  describe ".validate" do
    before do
      described_class.stub(
        validate_board_size: nil,
        validate_players: nil,
        validate_each_player: nil,
        validate_each_ship: nil,
      )
    end

    context "for board_size" do
      before { described_class.unstub(:validate_board_size) }

      it "raises an error if board_size is missing" do
        expect do
          described_class.validate({})
        end.to raise_error ConfigurationError
      end

      it "raises an error if board_size is not an integer" do
        expect do
          described_class.validate({"board_size" => "2"})
        end.to raise_error ConfigurationError
      end

      it "raises an error if board_size is less than 2" do
        described_class.validate({"board_size" => 2})
        expect do
          described_class.validate({"board_size" => 1})
        end.to raise_error ConfigurationError
      end

      it "raises an error if board_size is more than 26" do
        described_class.validate({"board_size" => 26})
        expect do
          described_class.validate({"board_size" => 27})
        end.to raise_error ConfigurationError
      end
    end

    context "for players" do
      before { described_class.unstub(:validate_players) }

      it "raises an error if players is missing" do
        expect do
          described_class.validate({})
        end.to raise_error ConfigurationError
      end

      it "raises an error if players is not an array" do
        expect do
          described_class.validate("players" => "not an array")
        end.to raise_error ConfigurationError
      end

      it "raises an error if there are less than 2 players" do
        expect do
          described_class.validate("players" => [double])
        end.to raise_error ConfigurationError
      end

      it "raises an error if there are more than 2 players" do
        expect do
          described_class.validate("players" => [double, double, double])
        end.to raise_error ConfigurationError
      end
    end

    context "for each player" do
      let(:player_hash) do
        {
          "name" => "bob",
          "ships" => [],
        }
      end

      before { described_class.unstub(:validate_each_player) }

      it "raises an error if the player is not a hash" do
        expect do
          described_class.validate("players" => ["not a hash"])
        end.to raise_error ConfigurationError
      end

      it "raises an error if name is missing" do
        expect do
          described_class.validate("players" => [player_hash.except("name")])
        end.to raise_error ConfigurationError
      end

      it "raises an error if ships is missing" do
        expect do
          described_class.validate("players" => [player_hash.except("ships")])
        end.to raise_error ConfigurationError
      end
    end

    context "for each ship" do
      let(:ship_hash) do
        {
          "type" => "patrol boat",
          "start" => "A1",
          "orientation" => "horizontal",
        }
      end

      before { described_class.unstub(:validate_each_ship) }

      it "raises an error if the ship is not a Hash" do
        expect do
          described_class.validate("players" => [{"ships" => ["not a hash"]}])
        end.to raise_error ConfigurationError
      end

      it "raises an error if type is missing" do
        expect do
          described_class.validate("players" =>
                                   [{"ships" => [ship_hash.except("type")]}])
        end.to raise_error ConfigurationError
      end

      it "raises an error if start is missing" do
        expect do
          described_class.validate("players" =>
                                   [{"ships" => [ship_hash.except("start")]}])
        end.to raise_error ConfigurationError
      end

      it "raises an error if orientation is missing" do
        expect do
          described_class.validate("players" =>
                                   [{"ships" => [ship_hash.except("orientation")]}])
        end.to raise_error ConfigurationError
      end

      it "raises an error if start is incorrectly formatted" do
        expect do
          described_class.validate("players" =>
                                   [{"ships" => [ship_hash.merge("start" => "1A")]}])
        end.to raise_error ConfigurationError
      end

      it "raises an error if type is not a valid ship type" do
        expect do
          described_class.validate("players" =>
                                   [{"ships" => [ship_hash.merge("type" => "invalid")]}])
        end.to raise_error ConfigurationError
      end

      it "raises an error if orientation is not a valid ship orientation" do
        expect do
          described_class.validate("players" =>
                                   [{"ships" => [ship_hash.merge("orientation" => "invalid")]}])
        end.to raise_error ConfigurationError
      end

      it "raises an error if the ship does not fit on the board" do
        expect do
          described_class.validate("board_size" => 1, "players" =>
                                   [{"ships" => [ship_hash]}])
        end.to raise_error ConfigurationError
      end
    end
  end
end
