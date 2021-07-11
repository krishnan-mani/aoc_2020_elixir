defmodule Day5 do

  @doc """
  Bisect a range and return the upper or lower half
    iex> Day5.bisect(0..127, :lower)
    0..63
    iex> Day5.bisect(0..63, :upper)
    32..63
  """
  def bisect(first..last = range, half) do
    midpoint = div(last - first, 2)
    case half do
      :upper -> midpoint + 1..last
      :lower -> first..midpoint
    end
  end

end
