stream = File.stream!("input/day2.txt")
password_lines = 
  stream 
  |> Enum.map(&String.trim/1) 
  |> Enum.map(&Day2.parse_line/1)
count = Enum.count(password_lines, fn(x) -> Day2.valid_password?(x.min, x.max, x.chr, x.password) end)
IO.puts "Number of valid passwords: #{count}"
