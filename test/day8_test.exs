defmodule Day8Test do
  use ExUnit.Case, async: true
  doctest Day8


  describe "process instructions and detect loop" do
    test "returns accumulator value before loop" do
      instruction_strings = """
      nop +0
      acc +1
      jmp +4
      acc +3
      jmp -3
      acc -99
      acc +1
      jmp -4
      acc +6
      """
      instructions = instruction_strings
                     |> String.split("\n")
                     |> Stream.map(&String.trim/1)
                     |> Stream.reject(fn str -> String.length(str) == 0 end)
                     |> Enum.map(&Day8.parse_instruction/1)
      assert {5, :loop} == Day8.process_instructions(instructions)
    end
  end
end