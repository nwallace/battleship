class Screen

  def render_guess_for(player)
    clear_screen
    greet_player(player)
    render_guess_board(player.guess_board)
    render_ship_board(player.ship_board)
  end

  private

  def greet_player(player)
    puts "Current commander: #{player.name}"
  end

  def render_guess_board(guess_board)
    puts "Your guesses:"
    size = guess_board.size
    render_board_header(size)
    render_board_border(size)
    guess_board.size.times do |row|
      render_guess_board_row(row, size, guess_board)
    end
    render_board_border(size)
    puts
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

  def render_ship_board(ship_board)
    puts "Your ships:"
    size = ship_board.size
    render_board_header(size)
    render_board_border(size)
    ship_board.size.times do |row|
      render_ship_board_row(row, size, ship_board)
    end
    render_board_border(size)
    puts
  end

  def render_ship_board_row(row, size, board)
    row_letter = ("A".."Z").to_a[row]
    inner_row = size.times.map do |i|
      block = row_letter + (i + 1).to_s
      ship = board.occupied_blocks[block]
      mark = if ship.nil?
               " "
             else
               if ship.hit_blocks.include?(block)
                 "x"
               else
                 ship.type[0]
               end
             end
      " #{mark} "
    end.join
    puts " #{row_letter} |" + inner_row + "|"
  end

  def clear_screen
    puts "\e[H\e[2J"
  end
end
