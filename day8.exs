instruction_lines = File.stream!("input/day8.txt")
instructions = instruction_lines
               |> Stream.map(&String.trim/1)
               |> Enum.map(&Day8.parse_instruction/1)
IO.puts("Value of accumulator before loop: #{Day8.process_instructions(instructions)}")