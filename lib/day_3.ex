defmodule Day3 do

  @doc """
  Indicates whether the particular co-ordinate is a tree

    iex> Day3.tree?("..##.......", 1)
    false
    iex> Day3.tree?("..##.......", 2)
    true
    iex> Day3.tree?("..##.......", 13)
    true
    iex> Day3.tree?("..##.......", 12)
    false
  """
  def tree?(line, index) do
    adjusted_index = rem(index, String.length(line))
    String.at(line, adjusted_index) == "#"
  end

end