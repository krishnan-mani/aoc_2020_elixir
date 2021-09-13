defmodule Day9 do
  @moduledoc false

  @doc """
  Validates number is the sum of any two distinct numbers in the sequence

    iex> Day9.valid?(3, [1, 2])
    true
    iex> Day9.valid?(7, [2, 4])
    false
    iex> Day9.valid?(14, [3, 7, 11])
    true
  """
  def valid?(num, sequence) do
    Enum.any?(sequence, fn x -> ((num - x) != x) and ((num - x) in sequence) end)
  end

end
