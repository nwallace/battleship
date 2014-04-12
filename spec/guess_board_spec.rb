require_relative "../lib/guess_board"

describe GuessBoard do

  describe "initialization" do
    it "does not take any arguments" do
      expect do
        GuessBoard.new
      end.not_to raise_error
    end
  end
end
