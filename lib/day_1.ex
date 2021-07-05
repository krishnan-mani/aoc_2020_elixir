defmodule Day1 do

  @doc """
  Finds the three numbers in a list that add up to sum
  
  ## Examples
    iex> Day1.three_sum([1, 2, 3, 5], 6)
    {1, 2, 3}
    iex> Day1.three_sum([1, 2], 6)
    {}
    iex> Day1.three_sum([1, 4, 2, 3], 6)
    {1, 2, 3}
    iex> Day1.three_sum([1, 2, 5, 7], 9)
    {}
  """
  def three_sum([], _sum) do {} end
  def three_sum([head | tail], sum) do
    complement = Day1.complement(tail, sum - head)
    case complement do 
      {b, c} -> {head, b, c}
      {} -> {}
    end
  end


  @doc """
  Finds the additive complement of the number and sum
  ## Examples
    iex> Day1.complement(3, 10)
    7
    iex> Day1.complement([3, 7], 10)
    {3, 7}
    iex> Day1.complement([3, 4, 5, 6], 9)
    {3, 6}
    iex> Day1.complement([2, 4, 5, 6], 9)
    {4, 5}
    iex> Day1.complement([3, 8], 10)
    {}
  """
  def complement([], _sum) do {} end
  def complement([head | tail], sum) do
    head_complement = complement(head, sum)
    if Enum.member?(tail, head_complement) do
      {head, head_complement}
    else
      complement(tail, sum)
    end
  end

  def complement(n, sum) do sum - n end

end