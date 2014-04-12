require_relative "../lib/screen"

describe Screen do

  let(:screen) { Screen.new }

  before do
    screen.stub(:puts)
  end

  describe "initialization" do
    it "takes no initialization arguments" do
      Screen.new
    end
  end

  describe "#render_guess_for" do
    it "renders each row of the player's guess_board"
    it "renders each row of the player's ship_board"
  end
end
