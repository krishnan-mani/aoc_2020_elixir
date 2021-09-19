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


end
