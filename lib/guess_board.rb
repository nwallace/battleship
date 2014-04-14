class GuessBoard

  attr_reader :size, :guesses

  def initialize(size)
    @size = size
    @guesses = {}
  end

  def get_guess
    guess = nil
    until valid_guess?(guess)
      prompt = if guess
                 "Coordiates are invalid. Please try again: "
               else
                 "Please enter your target coordiates: "
               end
      print prompt
      guess = gets.chomp
    end
    guess
  end

  def mark_hit(block)
    guesses[block] = :hit
    puts "Hit!"
    print "Press ENTER to continue..."
    gets
  end

  def mark_miss(block)
    guesses[block] = :miss
    puts "Miss"
    print "Press ENTER to continue..."
    gets
  end

  private

  def valid_guess?(guess)
    if guess.is_a?(String) &&
       guess =~ /\A[A-Z][0-9]+\Z/ &&
       within_board_size(guess[0].ord - 64) &&
       within_board_size(guess[/[0-9]+/].to_i) &&
       not_yet_guessed(guess)
      true
    else
      false
    end
  end

  def within_board_size(int)
    int.between?(1, size)
  end

  def not_yet_guessed(guess)
    !guesses.keys.include?(guess)
  end
end
