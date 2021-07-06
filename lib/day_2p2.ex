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


  @doc """
  Password is valid only if char is present at one of the positions

  ##Examples
  #
    iex> Day2Part2.password_valid?("abcde", 'a', 1, 3)
    true
    iex> Day2Part2.password_valid?("cdefg", 'b', 1, 3)
    false
    iex> Day2Part2.password_valid?("ccccccccc", 'c', 2, 9)
    false
  """
  def password_valid?(str, chr, pos1, pos2) do
    present_at_pos1 = String.at(str, pos1 - 1) |> String.to_charlist == chr 
    present_at_pos2 = String.at(str, pos2 - 1) |> String.to_charlist == chr
    case [present_at_pos1, present_at_pos2] do
      [true, true] -> false
      [false, false] -> false
      _ -> true
    end
  end

end
