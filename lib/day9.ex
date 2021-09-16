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
      fn num, acc ->
        precedents = Enum.slice(numbers, acc, sequence_length)
        case valid?(num, precedents) do
          true -> {:cont, acc + 1}
          false -> {:halt, num}
        end
      end
    )
  end

  @doc """
  Finds the contiguous sequence of numbers starting at the first element,
  that add up to sum

    iex> [1, 9] |> Day9.starting_sequence(10)
    [1, 9]
    iex> [1, 8] |> Day9.starting_sequence(10)
    []
    iex> [1, 7, 2] |> Day9.starting_sequence(10)
    [1, 7, 2]
    iex> [1, 7, 4] |> Day9.starting_sequence(10)
    []
    iex> [1, 2, 3, 4] |> Day9.starting_sequence(10)
    [1, 2, 3, 4]
    iex> [1, 2, 3, 4, 5] |> Day9.starting_sequence(10)
    [1, 2, 3, 4]
    iex> [1, 2, 3, 4, 5] |> Day9.starting_sequence(15)
    [1, 2, 3, 4, 5]
    iex> [1, 2, 3, 5, 4] |> Day9.starting_sequence(10)
    []
    iex> [1, 2, 3, 5] |> Day9.starting_sequence(10)
    []
    iex> [2, 3, 4] |> Day9.starting_sequence(6)
    []
  """
  def starting_sequence([first, second], sum) when sum == first + second, do: [first, second]
  def starting_sequence([_first, _second], _sum), do: []
  def starting_sequence([first, second | _tail], sum) when sum == first + second, do: [first, second]
  def starting_sequence([first, second | tail], sum) do
    case starting_sequence([second | tail], sum - first) do
      [] -> []
      some_list when is_list(some_list) -> [first | some_list]
    end
  end

  @doc """
  Find contiguous sequence adding up to sum

    iex> [1, 2, 3, 4] |> Day9.adds_up(3)
    [1, 2]
    iex> [1, 2, 3, 4] |> Day9.adds_up(9)
    [2, 3, 4]
    iex> [1, 2, 3, 4] |> Day9.adds_up(7)
    [3, 4]
    iex> [1, 2, 3, 4] |> Day9.adds_up(12)
    []
  """
  def adds_up(sequence, sum) do
    Enum.reduce_while(sequence, 0, fn num, acc ->
      sub_sequence = Enum.slice(sequence, acc..-1//1)
      case starting_sequence(sub_sequence, sum) do
        [] when acc < (length(sequence) - 2) -> {:cont, 1 + acc}
        [] -> {:halt, []}
        some_list when is_list(some_list) -> {:halt, some_list}
      end
    end)
  end


end
