defmodule Hangman.Game do
  defstruct(
    turns_left: 7,
    game_state: :initializing,
    letters: [],
    used: MapSet.new()
  )

  def new_game(word) do
    %Hangman.Game{
      letters: word |> String.codepoints()
    }
  end

  def new_game() do
    new_game(Dictionary.random_word())
  end

  def make_move(%{game_state: state} = game, _guess)
      when state in [:won, :lost] do
    game
    |> return_with_tally()
  end

  def make_move(game, guess) do
    case guess =~ ~r(^[a-z]$) do
      true ->
        game
        |> accept_move(guess, MapSet.member?(game.used, guess))
        |> return_with_tally()

      _ ->
        "Your guess can only be a single lowercase letter"
    end
  end

  def tally(game) do
    %{
      game_state: game.game_state,
      turns_left: game.turns_left,
      letters: game.letters |> reveal_guessed(game.used),
      used: game.used
    }
  end

  ##############################################################################

  # Private functions
  defp accept_move(game, _guess, _already_guessed = true) do
    Map.put(game, :game_state, :already_used)
  end

  defp accept_move(game, guess, _already_guessed) do
    Map.put(game, :used, MapSet.put(game.used, guess))
    |> score_guess(Enum.member?(game.letters, guess))
  end

  defp score_guess(game, _good_guess = true) do
    new_game_state =
      MapSet.new(game.letters)
      |> MapSet.subset?(game.used)
      |> maybe_won?()

    Map.put(game, :game_state, new_game_state)
  end

  defp score_guess(%{turns_left: 1} = game, _not_good_guess) do
    Map.put(game, :game_state, :lost)
  end

  defp score_guess(%{turns_left: turns_left} = game, _not_good_guess) do
    %{game | game_state: :bad_guess, turns_left: turns_left - 1}
  end

  def reveal_guessed(letters, used) do
    letters
    |> Enum.map(fn letter -> reveal_letter(letter, MapSet.member?(used, letter)) end)
  end

  defp reveal_letter(letter, _is_used = true), do: letter
  defp reveal_letter(_letter, _is_not_used), do: "_"

  defp maybe_won?(true), do: :won
  defp maybe_won?(_), do: :good_guess

  defp return_with_tally(game) do
    {game, tally(game)}
  end
end
