instruction_lines = File.stream!("input/day8.txt")
instructions = instruction_lines
               |> Stream.map(&String.trim/1)
               |> Enum.map(&Day8.parse_instruction/1)
{acc, :loop} = Day8.process_instructions(instructions)
IO.puts("Value of accumulator before loop: #{acc}")

case Day8.mutated_terminates?(instructions, 0, &Day8.swap_instruction/4, &Day8.process_instructions/1, :jmp, :nop) do
  false -> IO.puts("Instructions loop forever for any changes from `jmp` to `nop`")
  terminal_value -> IO.puts("Instructions terminate with accumulator value #{terminal_value}")
end