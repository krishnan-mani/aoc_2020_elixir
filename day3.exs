stream = File.stream!("input/day3.txt")
grid = stream
       |> Enum.map(&String.trim/1)
slope = %{right: 3, down: 1}
IO.puts("Number of trees encountered (right 3, down 1): #{Day3.count_trees(grid, slope)}")

slopes = [
  %{right: 1, down: 1},
  %{right: 3, down: 1},
  %{right: 5, down: 1},
  %{right: 7, down: 1},
  %{right: 1, down: 2}
]
tree_counts = Enum.map(slopes, fn slope -> Day3.count_trees(grid, slope) end)
IO.puts("Product of tree counts for different slopes: #{Enum.product(tree_counts)}")