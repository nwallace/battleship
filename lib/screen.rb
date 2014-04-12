class Screen

  def render_guess_for(player)
    clear_screen
    greet_player(player)
    render_guess_board(player.guess_board)
  end

  private

  def greet_player(player)
    puts "Current commander: #{player.name}"
  end

  def render_guess_board(guess_board)
    size = guess_board.size
    render_board_header(size)
    render_board_border(size)
    guess_board.size.times do |row|
      render_guess_board_row(row, size, guess_board)
    end
    render_board_border(size)
  end

  def render_board_header(size)
    puts "   " + size.times.map{|i| "  #{i+1}"}.join
  end

  def render_board_border(size)
    puts "   +" + size.times.map{|i| "---"}.join + "+"
  end

  def render_guess_board_row(row, size, board)
    row_letter = ("A".."Z").to_a[row]
    inner_row = size.times.map do |i|
      mark = case board.guesses[row_letter + (i + 1).to_s]
             when :hit
               "x"
             when :miss
               "o"
             else
               "_"
             end
      " #{mark} "
    end.join
    puts " #{row_letter} |" + inner_row + "|"
  end

  def clear_screen
    puts "\e[H\e[2J"
  end
end
