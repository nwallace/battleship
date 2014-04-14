class Game

  attr_reader :players

  def initialize(players, screen)
    @players = players
    @screen = screen
    @current_player_index = 0
  end

  def play
    until game_over?
      turn_for(current_player)
      advance_current_player
    end
    congratulate_winner(previous_player)
  end

  def current_player
    players[current_player_index]
  end

  def next_player
    next_player_index = (current_player_index + 1) % players.size
    players[next_player_index]
  end

  def previous_player
    players[current_player_index - 1]
  end

  def game_over?
    current_player.all_ships_sunk?
  end

  def turn_for(player)
    screen.render_guess_for(player)
    guess = player.guess
    if ship = next_player.receive_strike_at(guess)
      player.guess_board.mark_hit(guess)
      alert_of_sunken_ship(ship) if ship.sunk?
    else
      player.guess_board.mark_miss(guess)
    end
    print "Press ENTER to continue..."
    gets
  end

  private

  attr_reader :screen, :current_player_index

  def advance_current_player
    @current_player_index = (current_player_index + 1) % players.size
  end

  def congratulate_winner(player)
    puts "Congratulations, #{player.name}, you win!"
  end

  def alert_of_sunken_ship(ship)
    puts "#{ship.type.capitalize} sunk!"
  end
end
