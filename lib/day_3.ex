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
  Advances to the next position in the grid as per slope (when possible),
  and reports whether a tree was found at the position

    iex> grid = [ ".##.", "..##..#", "..##..##."]
    iex> slope = %{right: 3, down: 1}
    iex> %{right: 0, down: 0} |> Day3.advance_to_tree?(grid, slope)
    {:ok, %{position: %{right: 3, down: 1}, tree: true}}
    iex> slope = %{right: 3, down: 3}
    iex> %{right: 0, down: 0} |> Day3.advance_to_tree?(grid, slope)
    {:error, %{position: %{right: 3, down: 3}}}
  """
  def advance_to_tree?(position, grid, slope) do
    %{right: right, down: down} = position |> Day3.advance(slope)
    line = Enum.at(grid, down)
    case line do
      nil -> {:error, %{position: %{right: right, down: down}}}
      _ -> {:ok, %{position: %{right: right, down: down}, tree: Day3.tree?(line, right)}}
    end
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
    acc = %{position: %{right: 0, down: 0}, count: 0}
    Enum.reduce_while(grid, acc,
      fn _line, %{position: position, count: count} ->
        {result, outcome} = position |> Day3.advance_to_tree?(grid, slope)
        case result do
          :error -> {:halt, %{count: count}}
          _ -> {:cont, %{position: outcome.position,
            count: if outcome.tree do count + 1 else count end
            }}
        end
      end
    ).count
  end

end