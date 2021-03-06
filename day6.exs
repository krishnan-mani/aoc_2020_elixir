all_group_responses = File.read!("input/day6.txt")
                      |> String.split("\n\n")
unique_group_responses_count = all_group_responses
                               |> Enum.map(&Day6.unique_group_responses/1)
                               |> Enum.map(&length/1)
                               |> Enum.sum()
IO.puts "Sum of number of questions to which anyone answered `yes`: #{unique_group_responses_count}"

common_group_responses_count = all_group_responses
                               |> Enum.map(&Day6.common_responses/1)
                               |> Enum.map(&length/1)
                               |> Enum.sum()
IO.puts "Sum of common group responses of `yes`: #{common_group_responses_count}"