defmodule PatternMatch do
  def swap({a, b} = _t) do
    {b, a}
  end

  def same?({a, a} = _t) do
    true
  end

  def same?({_a, _b} = _t) do
    false
  end
end
