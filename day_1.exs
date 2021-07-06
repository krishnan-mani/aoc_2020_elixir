sum = 2020
stream = File.stream!("input/day1.txt")
numbers = stream |> Enum.map(&String.trim/1) |> Enum.map(&String.to_integer/1)
{a, b} = Day1.complement(numbers, sum)
IO.puts "day 1, part 1: product of two numbers that sum to 2020: #{a * b}"

{a, b, c} = Day1.three_sum(numbers, sum)
IO.puts "day 1, part 2: product of three numbers that sum to 2020: #{a * b * c}"
