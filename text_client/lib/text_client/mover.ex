defmodule TextClient.Mover do
  alias TextClient.State

  def make_move(%State{} = game) do
    tally = Hangman.make_move(game.game_service, game.guess)

    %State{game | tally: tally}
  end
end
