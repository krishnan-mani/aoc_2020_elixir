defmodule Day2 do

  @doc """
  Parses the password line

  ## Examples
  #
    iex> Day2.parse_line("1-13 r: gqdrspndrpsrjfjx")
    %{min: 1, max: 13, chr: 'r', password: "gqdrspndrpsrjfjx"}
  """
  def parse_line(str) do
    [min, rest] = String.split(str, "-")
    [max, chr, password] = String.split(rest, " ")
    %{min: String.to_integer(min), 
      max: String.to_integer(max),
      chr: String.to_charlist(String.at(chr, 0)),
      password: password}
  end

  @doc """
  Validate the password based on minimum and maximum occurences of character

  ## Examples
  #
    iex> Day2.valid_password?(1, 3, 'a', "abcde")
    true
    iex> Day2.valid_password?(1, 3, 'a', "bcde")
    false
    iex> Day2.valid_password?(1, 3, 'a', "aaabc")
    true
    iex> Day2.valid_password?(1, 3, 'a', "aaaabc")
    false
  """
  def valid_password?(min, max, chr, password) do 
    count = Day2.count_char(chr, password)
    count >= min && count <= max
  end

  @doc """
  Counts the number of occurences of the character in the string

  ##Examples
  #
    iex> Day2.count_char('a', "abc")
    1
    iex> Day2.count_char('a', "bc")
    0
    iex> Day2.count_char('a', "abcaa")
    3
  """
  def count_char(chr, str) do
    Enum.count(String.to_charlist(str), fn x -> x == List.first(chr) end)
  end

end
