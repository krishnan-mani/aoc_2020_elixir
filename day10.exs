adaptors = File.stream!("input/day10.txt")
           |> Stream.map(&String.trim/1)
           |> Stream.reject(fn x -> String.length(x) == 0 end)
           |> Enum.map(&String.to_integer/1)

%{1 => x, 3 => y} = adaptors
                    |> Day10.joltages()
                    |> Day10.count_differences()

IO.puts("number of 1-jolt differences multiplied by the number of 3-jolt differences: #{x * y}")
