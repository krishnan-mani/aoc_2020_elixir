stream = File.stream!("input/day3.txt")
grid = stream |> Enum.map(&String.trim/1)
slope = %{right: 3, down: 1}
IO.puts("Number of trees encountered (right 3, down 1): #{Day3.count_trees(grid, slope)}")
