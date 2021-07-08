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

  @doc """
    Reveals current position on grid after a move down

      iex> start_position = %{right: 0, down: 0}
      %{right: 0, down: 0}
      iex> start_position |> Day3.advance(%{right: 3, down: 1})
      %{right: 3, down: 1}
      iex> start_position |> Day3.advance(%{right: 3, down: 1}) |> Day3.advance(%{right: 3, down: 1})
      %{right: 6, down: 2}
  """
  def advance(position, %{right: right, down: down}) do
    new_right = position.right + right
    new_down = position.down + down
    %{right: new_right, down: new_down}
  end

  @doc """
  Count trees encountered following a particular slope through grid

    iex> grid = [ ".##.", "..##..#", "..##..##."]
    iex> slope = %{right: 3, down: 1}
    %{right: 3, down: 1}
    iex> Day3.count_trees(grid, slope)
    2
  """
  def count_trees(grid, slope) do
    grid_height = Enum.count(grid)
    acc = %{position: %{right: 0, down: 0}, count: 0}
    Enum.reduce(0..(grid_height - 2), acc,
      fn _idx, %{position: position, count: count} ->
        new_position = position |> Day3.advance(slope)
        line = Enum.at(grid, new_position.down)
        index = new_position.right
        new_count = case Day3.tree?(line, index) do
          true -> count + 1
          false -> count
        end
        %{position: new_position, count: new_count}
      end
    ).count
  end

end