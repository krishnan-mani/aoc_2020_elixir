defmodule Day6 do

  @doc ~S"""
  Group responses into questions answered

    iex> "abc" |> Day6.group_response
    'abc'
    iex> "abca" |> Day6.group_response
    'abc'
    iex> "abc\nab" |> Day6.group_response
    'abc'
    iex> "abc\nab\ncba" |> Day6.group_response
    'abc'
  """
  def group_response(str) do
    case str |> String.split("\n") do
      [x] -> to_charlist(x) |> unique_responses()
      [hd | tl] = lst -> tl
                         |> Enum.reduce(hd, fn x, acc -> acc <> x end)
                         |> to_charlist()
                         |> unique_responses()
    end
  end

  def unique_responses(chr_list) do
    chr_list |> Enum.sort |> Enum.dedup
  end

end
