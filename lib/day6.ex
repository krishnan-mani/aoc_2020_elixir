defmodule Day6 do

  @doc ~S"""
  Group responses into questions answered

    iex> "abc" |> Day6.unique_group_responses
    'abc'
    iex> "abca" |> Day6.unique_group_responses
    'abc'
    iex> "abc\nab" |> Day6.unique_group_responses
    'abc'
    iex> "abc\nab\ncba" |> Day6.unique_group_responses
    'abc'
  """
  def unique_group_responses(str) do
    case str
         |> String.split("\n") do
      [x] -> x |> unique_responses()
      [hd | tl] -> tl
                   |> Enum.reduce(hd, fn x, acc -> acc <> x end)
                   |> unique_responses()
    end
  end

  def unique_responses(str) do
    str
    |> to_charlist()
    |> Enum.sort()
    |> Enum.dedup()
  end

end
