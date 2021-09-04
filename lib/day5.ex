defmodule Day5 do

  @doc """
  Bisect a range and return the greater or lesser half
    iex> range = 0..127
    iex> range = range |> Day5.bisect(:lesser)
    0..63
    iex> range = range |> Day5.bisect(:greater)
    32..63
    iex> range = range |> Day5.bisect(:lesser)
    32..47
    iex> range = range |> Day5.bisect(:greater)
    40..47
    iex> range = range |> Day5.bisect(:greater)
    44..47
    iex> range = range |> Day5.bisect(:lesser)
    44..45
    iex> range |> Day5.bisect(:lesser)
    44..44
    iex> range |> Day5.bisect(:greater)
    45..45
  """
  def bisect(first..last, half) do
    midpoint = first + div(last - first, 2)
    case half do
      :greater -> (midpoint + 1)..last
      :lesser -> first..midpoint
    end
  end

  @doc """
  Get seat ID
    iex> Day5.seat_ID("BFFFBBFRRR")
    567
    iex> Day5.seat_ID("FFFBBBFRRR")
    119
  """
  def seat_ID(boarding_pass) do
    row_charlist = String.slice(boarding_pass, 0, 7) |> to_charlist
    column_charlist = String.slice(boarding_pass, -3, 3) |> to_charlist
    (row(row_charlist) * 8) + column(column_charlist)
  end

  @doc """
  Get column
    iex> Day5.column('RLR')
    5
  """
  def column(column_charlist) do converge(column_charlist, ?R, ?L) end

  @doc """
  Get row number
    iex> Day5.row('FBFBBFF')
    44
  """
  def row(row_charlist) do converge(row_charlist, ?B, ?F) end

  defp converge(chrlist, greater_selector, lesser_selector) do
    range = 0..(Integer.pow(2, Enum.count(chrlist)) -1)
    converged..converged = Enum.reduce(chrlist, range, fn selection, range ->
      case selection do
        ^greater_selector -> range |> bisect(:greater)
        ^lesser_selector -> range |> bisect(:lesser)
      end
    end)
    converged
  end

end
