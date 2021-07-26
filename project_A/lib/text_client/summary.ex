defmodule TextClient.Summary do
  def display(%{tally: tally} = game) do
    IO.puts([
      "\n",
      "Word so far: #{Enum.join(tally.letters, " ")}\n",
      "Turns left: #{tally.turns_left}\n",
      "Used letters: #{tally.used |> Enum.to_list() |> Enum.join(", ")}\n"
    ])

    game
  end
end
