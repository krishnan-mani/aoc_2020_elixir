defmodule Day2Part2 do

  @doc """
  Parse password line for positions of character

  ## Examples
  #
    iex> Day2Part2.parse_line("1-3 a: abcde")
    %{pos1: 1, pos2: 3, chr: 'a', password: "abcde"}
  """
  def parse_line(str) do
    [pos1, tail] = String.split(str, "-")
    [pos2, chr, password] = String.split(tail, " ")
    %{
      pos1: pos1 |> String.to_integer,
      pos2: pos2 |> String.to_integer,
      chr: chr |> String.at(0) |> String.to_charlist,
      password: password
    }
  end
end
