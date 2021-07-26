defmodule Lists do
  require Integer
  def len([]), do: 0
  def len([_h | t]), do: 1 + len(t)

  def sum([]), do: 0
  def sum([h | t]), do: h + sum(t)

  def double([]), do: []
  def double([h | t]), do: [2 * h | double(t)]

  def square([]), do: []
  def square([h | t]), do: [h * h | square(t)]

  def sum_pairs([]), do: []
  def sum_pairs([h1, h2 | tail]), do: [h1 + h2 | sum_pairs(tail)]

  def even_length?([]), do: true
  def even_length?([_h1, _h2 | tail]), do: even_length?(tail)
  def even_length?([_h1 | _tail]), do: false
end
