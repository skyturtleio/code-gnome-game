defmodule TextClient.Player do
  @moduledoc """
  Implements play/1 functions to go through a game of Hangman
  """

  alias TextClient.{Mover, Prompter, State, Summary}

  # won, lost, good guess, bad guess, already guessed

  def play(%State{tally: %{game_state: :won}}) do
    exit_with_message("You WON!")
  end

  def play(%State{tally: %{game_state: :lost}}) do
    exit_with_message("Sorry, you lost")
  end

  def play(%State{tally: %{game_state: :good_guess}} = game) do
    continue_with_message(game, "Good guess!")
  end

  def play(%State{tally: %{game_state: :bad_guess}} = game) do
    continue_with_message(game, "Sorry, that isn't in the word")
  end

  def play(%State{tally: %{game_state: :already_used}} = game) do
    continue_with_message(game, "You've already used that letter")
  end

  def play(game) do
    continue(game)
  end

  def continue_with_message(game, msg) do
    IO.puts(msg)
    continue(game)
  end

  def continue(game) do
    game
    |> Summary.display()
    |> Prompter.accept_move()
    |> Mover.make_move()
    |> play()
  end

  def exit_with_message(msg) do
    IO.puts(msg)
    exit(:normal)
  end
end
