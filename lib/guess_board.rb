class GuessBoard

  def initialize(board_size)
    @board_size = board_size
  end

  def get_guess
    guess = nil
    until valid_guess?(guess)
      prompt = if guess
                 "Coordiates are invalid. Please try again: "
               else
                 "Please enter your target coordiates: "
               end
      guess = gets.chomp
    end
  end

  private

  attr_reader :board_size

  def valid_guess?(guess)
    if guess.is_a?(String) &&
       guess =~ /\A[A-Z][0-9]+\Z/ &&
       within_board_size(guess[0].ord - 64) &&
       within_board_size(guess[/[0-9]+/].to_i)
      true
    else
      false
    end
  end

  def within_board_size(int)
    int.between?(1, board_size)
  end
end
