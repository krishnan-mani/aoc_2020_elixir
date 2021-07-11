boarding_passes = File.stream!("input/day5.txt") |> Enum.map(&String.trim/1)
seat_IDs = Enum.map(boarding_passes, fn x -> Day5.seat_ID(x) end)
max_seat_ID = Enum.max(seat_IDs)
IO.puts("Boarding pass with max ID: #{max_seat_ID}")
