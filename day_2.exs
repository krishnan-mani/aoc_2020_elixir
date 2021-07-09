stream = File.stream!("input/day2.txt")
password_lines =
  stream
  |> Enum.map(&String.trim/1)
  |> Enum.map(&Day2.parse_line/1)
count = Enum.count(password_lines, fn (x) -> Day2.valid_password?(x.min, x.max, x.chr, x.password) end)
IO.puts "Number of valid passwords: #{count}"

password_lines_part2 =
  stream
  |> Enum.map(&String.trim/1)
  |> Enum.map(&Day2Part2.parse_line/1)
count = Enum.count(password_lines_part2, fn (x) -> Day2Part2.valid_password?(x.password, x.chr, x.pos1, x.pos2) end)
IO.puts "Per toboggan policy, number of valid passwords: #{count}"
