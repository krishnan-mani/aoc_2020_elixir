defmodule Day5 do

  @doc """
  Bisect a range and return the upper or lower half
    iex> range = 0..127
    iex> range = range |> Day5.bisect(:lower)
    0..63
    iex> range = range |> Day5.bisect(:upper)
    32..63
    iex> range = range |> Day5.bisect(:lower)
    32..47
    iex> range = range |> Day5.bisect(:upper)
    40..47
    iex> range = range |> Day5.bisect(:upper)
    44..47
    iex> range = range |> Day5.bisect(:lower)
    44..45
    iex> lower_bound = range |> Day5.bisect(:lower)
    44..44
    iex> upper_bound = range |> Day5.bisect(:upper)
    45..45
  """
  def bisect(first..last = range, half) do
    midpoint = first + div(last - first, 2)
    case half do
      :upper -> midpoint + 1..last
      :lower -> first..midpoint
    end
  end

  @doc """
  Get column
    iex> Day5.column('RLR')
    5
  """
  def column(column_charlist) do
    range = 0..(Integer.pow(2, Enum.count(column_charlist)) - 1)
    Enum.reduce(column_charlist, range, fn selection, range ->
      range = case selection do
        ?R -> range |> bisect(:upper)
        ?L -> range |> bisect(:lower)
      end
    end).first
  end

  @doc """
  Get row number
    iex> Day5.row('FBFBBFF')
    44
  """
  def row(row_charlist) do
    range = 0..(Integer.pow(2, Enum.count(row_charlist)) - 1)
    Enum.reduce(row_charlist, range, fn selection, range ->
      range = case selection do
        ?F -> range |> bisect(:lower)
        ?B -> range |> bisect(:upper)
      end
    end).first
  end

end
