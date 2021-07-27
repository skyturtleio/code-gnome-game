defmodule Dictionary.Application do
  @moduledoc """
  Application entry point for the Dictionary application
  """


  def start(_type, _args) do
    Dictionary.WordList.start_link()
  end
end
