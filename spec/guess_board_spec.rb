require_relative "../lib/guess_board"

describe GuessBoard do
  let(:size)        { 10 }
  let(:guess_board) { GuessBoard.new(size) }

  before do
    GuessBoard.any_instance.stub(puts: nil, print: nil)
  end

  describe "initialization" do
    it "takes the board_size" do
      expect do
        GuessBoard.new(10)
      end.not_to raise_error
    end
  end

  describe "#get_guess" do
    it "gets a guess" do
      expect(guess_board).to receive(:gets).and_return(guess="A1")
      expect(guess_board.get_guess).to eq guess
    end

    it "rejects the guess and asks again until the guess is a valid board block" do
      guess_board = GuessBoard.new(1)
      expect(guess_board).to receive(:gets)
        .exactly(4).times
        .and_return("1A", "B1", "A2", "A1")
      guess_board.get_guess
    end

    it "rejects the guess and asks again until the guess is a new guess" do
      guess_board = GuessBoard.new(2)
      guess_board.stub(guesses: {"A1" => :hit})
      expect(guess_board).to receive(:gets)
        .twice
        .and_return("A1", "B1")
      guess_board.get_guess
    end
  end

  describe "#mark_hit" do
    it "marks the given block as a hit" do
      guess_board.mark_hit("A1")
      guess_board.guesses["A1"].should == :hit
    end
  end

  describe "#mark_miss" do
    it "marks the given block as a miss" do
      guess_board.mark_miss("A1")
      guess_board.guesses["A1"].should == :miss
    end
  end
end
