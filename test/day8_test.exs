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

  describe "swap instructions" do
    setup do
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
      %{instructions: instructions}
    end

    test "detects when there is no loop", %{instructions: instructions} do
      assert 8 == Day8.mutated_terminates?(
               instructions,
               0,
               &Day8.swap_instruction/4,
               &Day8.process_instructions/1,
               :jmp,
               :nop
             )
    end

    test "detects when there is a loop", %{instructions: instructions} do
      assert false == Day8.mutated_terminates?(
               instructions,
               0,
               &Day8.swap_instruction/4,
               &Day8.process_instructions/1,
               :nop,
               :jmp
             )
    end

  end
end