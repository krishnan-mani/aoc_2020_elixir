all_lines = File.read!("input/day4.txt")
all_password_lines = String.split(all_lines, "\n\n")
passwords = all_password_lines
            |> Enum.map(&Day4.parse_password/1)
valid_password_count = Enum.count(passwords, fn x -> Day4.valid_password?(x)  end)
IO.puts("Number of valid passwords: #{valid_password_count}")