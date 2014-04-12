class Game

  attr_reader :players

  def initialize(players, screen)
    @players = players
    @current_player_index = 0
  end

  def play
    until game_over?
      turn_for(current_player)
      advance_current_player
    end
  end

  def current_player
    players[current_player_index]
  end

  def next_player
    players[current_player_index + 1]
  end

  def previous_player
    players[current_player_index - 1]
  end

  def game_over?
    current_player.all_ships_sunk?
  end

  private

  attr_reader :current_player_index

  def turn_for(player)
    screen.render_guess_for(player)
    guess = player.guess
    next_player.receive_strike_at(guess)
  end

  def advance_current_player
    @current_player_index = (current_player_index + 1) % players.size
  end
end
