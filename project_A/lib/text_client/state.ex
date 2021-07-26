defmodule TextClient.State do
  @moduledoc """
  Contains the struct for the State of the game
  """

  defstruct(
    game_service: nil,
    tally: nil,
    guess: "",
    used: nil
  )

end
