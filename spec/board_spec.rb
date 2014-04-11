require_relative "../lib/board"

describe Board do

  describe "initialization" do
    it "takes the ships for two players and saves them" do
      ships_1 = double
      ships_2 = double
      board = Board.new(ships_1, ships_2)
      board.player_1_ships.should == ships_1
      board.player_2_ships.should == ships_2
    end
  end
end
