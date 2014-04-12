require_relative "../lib/guess_board"

describe GuessBoard do
  let(:size)        { 10 }
  let(:guess_board) { GuessBoard.new(size) }

  describe "initialization" do
    it "takes the board_size" do
      expect do
        GuessBoard.new(10)
      end.not_to raise_error
    end
  end

  describe "#get_guess" do
    it "gets a guess" do
      expect(guess_board).to receive(:gets).and_return("A1")
      guess_board.get_guess
    end

    it "rejects the guess and asks again until the guess is a valid board block" do
      guess_board = GuessBoard.new(1)
      expect(guess_board).to receive(:gets)
        .exactly(4).times
        .and_return("1A", "B1", "A2", "A1")
      guess_board.get_guess
    end
  end
end
