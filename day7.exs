rules = File.stream!("input/day7.txt")
model = rules
        |> Stream.map(&String.trim/1)
        |> Enum.reduce(%{}, fn rule, acc -> Day7.process_rule(rule, acc) end)
IO.puts("Number of colours that can contain shiny gold bags: #{Day7.count_container_colours(model)}")

model_with_counts = rules
                    |> Stream.map(&String.trim/1)
                    |> Enum.reduce(%{}, fn rule, acc -> Day7.process_bag_counts(rule, acc) end)
IO.puts("Number of bags in one shiny gold bag: #{Day7.count_bags("shiny gold", model_with_counts) - 1}")