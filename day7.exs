rules = File.stream!("input/day7.txt")
model = rules
        |> Stream.map(&String.trim/1)
        |> Enum.reduce(%{}, fn rule, acc -> Day7.process_rule(rule, acc) end)
IO.puts("Number of colours that can contain shiny gold bags: #{Day7.count_container_colours(model)}")