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

  @doc ~S"""
  Common responses from a group

    iex> "abc" |> Day6.common_responses()
    'abc'
    iex> "ab\nac" |> Day6.common_responses()
    'a'
    iex> "a\nb\nc" |> Day6.common_responses()
    ''
    iex> "a\na\na\na" |> Day6.common_responses()
    'a'
    iex> "a" |> Day6.common_responses()
    'a'
    iex> "cba\nab\nc" |> Day6.common_responses()
    ''
  """
  def common_responses(str) do
    case str |> String.split("\n") do
      [x] -> unique_responses(x)
      [hd | tl] -> tl |> Enum.reduce(unique_responses(hd),
             fn x, acc -> to_charlist(acc) |> Enum.filter(fn chr -> chr in to_charlist(x) end)
             end)
    end
  end

end
