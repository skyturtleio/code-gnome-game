defmodule GameTest do
  use ExUnit.Case
  alias Hangman.Game
  doctest Hangman

  test "new_game returns structure" do
    game = Game.new_game()

    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert game.letters |> length() > 0
  end

  test "state isn't changed for :won or :lost game" do
    game = Game.new_game() |> Map.put(:game_state, :won)
    assert {^game, _} = Game.make_move(game, "x")
  end

  test "first occurence of letter is not already used" do
    {game, _tally} = Game.new_game() |> Game.make_move("x")

    assert game.game_state != :already_used
  end

  test "second occurrence of letter is already used" do
    game = Game.new_game()
    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state != :already_used
    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state == :already_used
  end

  test "a good guess is recognized" do
    game = Game.new_game("turtle")
    {game, _tally} = Game.make_move(game, "u")

    assert game.game_state == :good_guess
    assert game.turns_left == 7
  end

  test "a fully guessed word is a won game" do
    game = Game.new_game("turtle")
    {game, _tally} = Game.make_move(game, "t")
    assert game.turns_left == 7
    {game, _tally} = Game.make_move(game, "u")
    assert game.turns_left == 7
    {game, _tally} = Game.make_move(game, "r")
    assert game.turns_left == 7
    {game, _tally} = Game.make_move(game, "l")
    assert game.turns_left == 7
    {game, _tally} = Game.make_move(game, "e")
    assert game.turns_left == 7

    assert game.game_state == :won
  end

  test "a bad guess is recognized" do
    game = Game.new_game("turtle")
    {game, _tally} = Game.make_move(game, "x")

    assert game.game_state == :bad_guess
    assert game.turns_left == 6
  end

  test "a lost game is recognized" do
    game = Game.new_game("z")
    {game, _tally} = Game.make_move(game, "a")
    assert game.game_state == :bad_guess
    assert game.turns_left == 6
    {game, _tally} = Game.make_move(game, "b")
    assert game.game_state == :bad_guess
    assert game.turns_left == 5
    {game, _tally} = Game.make_move(game, "c")
    assert game.game_state == :bad_guess
    assert game.turns_left == 4
    {game, _tally} = Game.make_move(game, "d")
    assert game.game_state == :bad_guess
    assert game.turns_left == 3
    {game, _tally} = Game.make_move(game, "e")
    assert game.game_state == :bad_guess
    assert game.turns_left == 2
    {game, _tally} = Game.make_move(game, "f")
    assert game.game_state == :bad_guess
    assert game.turns_left == 1
    {game, _tally} = Game.make_move(game, "g")
    assert game.game_state == :lost
  end

  test "alternate won test using for comprehension" do
    moves = [
      {"w", :good_guess},
      {"i", :good_guess},
      {"b", :good_guess},
      {"l", :good_guess},
      {"e", :won}
    ]

    game = Game.new_game("wibble")

    Enum.reduce(
      moves,
      game,
      fn {guess, state}, updated_game ->
        {updated_game, _tally} = Game.make_move(updated_game, guess)
        assert updated_game.game_state == state
        updated_game
      end
    )
  end

  test "every element of letters is a lowercase letter" do
    game = Game.new_game()

    assert Enum.all?(game.letters, &(&1 =~ ~r(^[a-z]*$))) == true
  end
end
