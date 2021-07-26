defmodule TextClient.Prompter do
  alias TextClient.State
  @moduledoc """
  Accepts the game and displays a friendly prompt for the user
  """

  @doc """
  Accepts user input
  """
  def accept_move(%State{} = game) do
    IO.gets("Make a guess: ")
    |> check_input(game)
  end

  defp check_input({:error, reason}, _game) do
    IO.puts("Error: #{reason}")
    exit(:normal)
  end

  defp check_input(:eof, _game) do
    IO.puts("Looks like you gave up")
    exit(:normal)
  end

  defp check_input(input, %State{} = game) do
    input = String.trim(input)

    cond do
      input =~ ~r/\A[a-z]\z/ ->
        Map.put(game, :guess, input)

      true ->
        IO.puts("Please enter a lowercase letter")
        accept_move(game)
    end
  end
end
