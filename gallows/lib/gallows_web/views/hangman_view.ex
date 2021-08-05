defmodule GallowsWeb.HangmanView do
  use GallowsWeb, :view

  def words_so_far(tally) do
    tally.letters |> Enum.join(" ")
  end
end
