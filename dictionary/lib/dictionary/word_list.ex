defmodule Dictionary.WordList do
  @doc """
  Initializes an agent with the complete word_list as its state
  """
  def start_link() do
    Agent.start_link(&word_list/0)
  end

  @doc """
  Accepts an Agent's PID and returns a random word from the word_list.
  The Agent's state contains the word_list.
  """
  def random_word(agent) do
    Agent.get(agent, &Enum.random/1)
  end

  @doc """
  Creates an Elixir List of words contained in a text file under the
  assets directory.
  """
  def word_list() do
    "../../assets/words.txt"
    |> Path.expand(__DIR__)
    |> File.read!()
    |> String.split(~r/\n/)
  end
end
