boarding_passes = File.stream!("input/day5.txt")
                  |> Enum.map(&String.trim/1)
seat_IDs = Enum.map(boarding_passes, fn x -> Day5.seat_ID(x) end)
max_seat_ID = Enum.max(seat_IDs)
IO.puts("Boarding pass with max ID: #{max_seat_ID}")

missing_boarding_pass = (seat_IDs
                         |> Enum.sort
                         |> Enum.drop_while(fn x -> Enum.member?(seat_IDs, x + 1) end)
                         |> Enum.at(0)) + 1
IO.puts("Your seat ID: #{missing_boarding_pass}")

