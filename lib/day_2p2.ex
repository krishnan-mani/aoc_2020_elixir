defmodule Day2Part2 do

  @doc """
  Parse password line for positions of character

  ## Examples
  #
    iex> Day2Part2.parse_line("1-3 a: abcde")
    %{pos1: 1, pos2: 3, chr: 'a', password: "abcde"}
  """
  def parse_line(str) do
    [position, tail] = String.split(str, "-")
    [alt_position, chr, password] = String.split(tail, " ")
    %{
      pos1: position |> String.to_integer,
      pos2: alt_position |> String.to_integer,
      chr: chr |> String.at(0) |> String.to_charlist,
      password: password
    }
  end


  @doc """
  Password is valid only if char is present at one of the positions

  ##Examples
  #
    iex> Day2Part2.valid_password?("abcde", 'a', 1, 3)
    true
    iex> Day2Part2.valid_password?("cdefg", 'b', 1, 3)
    false
    iex> Day2Part2.valid_password?("ccccccccc", 'c', 2, 9)
    false
  """
  def valid_password?(password, chr, pos1, pos2) do
    present_at_pos1 = String.at(password, pos1 - 1) |> String.to_charlist == chr 
    present_at_pos2 = String.at(password, pos2 - 1) |> String.to_charlist == chr
    case [present_at_pos1, present_at_pos2] do
      [true, true] -> false
      [false, false] -> false
      _ -> true
    end
  end

end
