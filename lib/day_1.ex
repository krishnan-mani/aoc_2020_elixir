defmodule Day1 do

  @doc """
  Finds the three numbers in a list that add up to sum
  
  ## Examples
    iex> Day1.three_sum([1, 2], 6)
    {}
    iex> Day1.three_sum([1, 2, 3], 6)
    {1, 2, 3}
    iex> Day1.three_sum([1, 2, 4], 6)
    {}
    iex> Day1.three_sum([4, 1, 3, 2], 6)
    {1, 3, 2}
    iex> Day1.three_sum([1, 4, 3, 2], 6)
    {1, 3, 2}
  """
  def three_sum([_a, _b], _sum) do {} end
  def three_sum([a, b, c], sum) when (a + b + c) == sum do {a, b, c} end
  def three_sum([a, b, c], sum) when (a + b + c) != sum do {} end
  def three_sum([head | tail], sum) do
    case Day1.complement(tail, sum - head) do
      {b, c} -> {head, b, c}
      {} -> three_sum(tail, sum) 
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
