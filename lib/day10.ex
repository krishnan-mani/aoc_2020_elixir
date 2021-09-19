defmodule Day10 do
  @moduledoc false

  @doc """
  Find adaptor given joltage, and choice of other adaptors

    iex> Day10.get_next_adaptor(9, [10, 11])
    10
    iex> Day10.get_next_adaptor(9, [11, 12])
    11
    iex> Day10.get_next_adaptor(9, [12, 15, 17])
    12
  """
  def get_next_adaptor(joltage, adaptors) do
    Enum.filter(adaptors, fn x -> (x - joltage) in [1, 2, 3]  end)
    |> Enum.min()
  end

  @doc """
  Given a bunch of adaptors of different joltages, combine them all based on the constraints

    iex> Day10.combine_adaptors([1, 7, 5, 2])
    [1, 2, 5, 7]
  """
  def combine_adaptors(adaptors, socket_joltage \\ 0) do
    %{combination: combination} = Enum.reduce(
      adaptors,
      %{joltage: socket_joltage, combination: []},
      fn _x, %{joltage: joltage, combination: combination} ->
        next_joltage = Day10.get_next_adaptor(joltage, adaptors -- combination)
        %{joltage: next_joltage, combination: List.insert_at(combination, -1, next_joltage)}
      end
    )
    combination
  end

  @doc """
  Calculate difference between successive elements

    iex> Day10.map_differences([1, 2, 5])
    [1, 3]
    iex> Day10.map_differences([1, 1, 1])
    [0, 0]
  """
  def map_differences([_n]), do: []
  def map_differences([x, y]), do: [y - x]
  def map_differences([x, y | tail]), do: map_differences([x, y]) ++ map_differences([y | tail])

  @doc """
  Get the frequencies of differences

    iex> Day10.count_differences([1, 2, 4])
    %{1 => 1, 2 => 1}
  """
  def count_differences(numbers) do
    numbers
    |> Day10.map_differences()
    |> Enum.frequencies()
  end

  def joltages(adaptors) when is_list(adaptors) do
    combined_adaptors = combine_adaptors(adaptors)
    device_joltage = 3 + List.last(combined_adaptors)
    [0] ++ combined_adaptors ++ [device_joltage]
  end

end
