class Game

  def initialize(player_1, player_2)
    @player_1 = player_1
    @player_2 = player_2
  end

  def play
    player = player_1
    until game_over?(player) do
      player.guess
      player = next_player(player)
    end
  end

  private

  attr_reader :board, :player_1, :player_2

  def next_player(current_player)
    if current_player == player_1
      player_2
    else
      player_1
    end
  end

  def game_over?(current_player)
    current_player.has_won?
  end
end
