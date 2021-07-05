sum = 2020
stream = File.stream!("input/day1.txt")
numbers = stream |> Enum.map(&String.trim/1) |> Enum.map(&String.to_integer/1)
{a, b} = Day1.complement(numbers, sum)
IO.puts "product: #{a * b}"
