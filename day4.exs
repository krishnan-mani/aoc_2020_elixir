all_lines = File.read!("input/day4.txt")
all_passport_lines = String.split(all_lines, "\n\n")
passports = all_passport_lines
            |> Enum.map(&Day4.parse_passport/1)
valid_passport_count = Enum.count(passports, fn x -> Day4.valid_passport?(x)  end)
IO.puts("Number of valid passports: #{valid_passport_count}")

fully_valid_passport_count = Enum.count(passports, fn x -> Day4.fully_valid_passport?(x) end)
IO.puts("Number of fully valid passports: #{fully_valid_passport_count}")