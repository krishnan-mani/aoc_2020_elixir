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

  @doc """
  First number in the list that is not the sum of two different numbers in the
  preceding sequence of specified length
  """
  def first_invalid_number(numbers, sequence_length) do
    sequence = Enum.drop(numbers, sequence_length)
    Enum.reduce_while(
      sequence,
      0,
      fn x, acc ->
        precedents = Enum.slice(numbers, acc, sequence_length)
        case valid?(x, precedents) do
          true -> {:cont, acc + 1}
          false -> {:halt, x}
        end
      end
    )
  end

end
