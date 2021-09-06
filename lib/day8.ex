defmodule Day8 do
  @moduledoc false

  @doc """
  given the instruction index, and the accumulator,
  returns the next instruction index and accumulator for different instructions

    iex> Day8.process({:nop, 5}, 12, 7)
    %{index: 13, acc: 7}
    iex> Day8.process({:jmp, 4}, 12, 7)
    %{index: 16, acc: 7}
    iex> Day8.process({:acc, 2}, 12, 7)
    %{index: 13, acc: 9}
  """
  def process({:nop, _}, index, acc), do: %{index: index + 1, acc: acc}
  def process({:jmp, jump_by}, index, acc), do: %{index: index + jump_by, acc: acc}
  def process({:acc, inc_by}, index, acc), do: %{index: index + 1, acc: acc + inc_by}

  @doc """
  Process instructions until loop

    iex> no_loop_instructions = [{:acc, 1}, {:nop, 4}, {:jmp, 2}, {:nop, 1}, {:nop, 2}, {:acc, 2}]
    iex> Day8.process_instructions(no_loop_instructions)
    3
  """
  def process_instructions(instructions, index \\ 0, acc \\ 0, processed \\ []) do
    if index in processed do
      acc
    else
      case Enum.at(instructions, index, :none) do
        :none -> acc
        instruction -> %{index: next_index, acc: acc} = Day8.process(instruction, index, acc)
                       process_instructions(instructions, next_index, acc, [index | processed])
      end
    end
  end

  @doc """
  Parse instruction line

    iex> Day8.parse_instruction("nop +7")
    {:nop, 7}
    iex> Day8.parse_instruction("jmp +12")
    {:jmp, 12}
    iex> Day8.parse_instruction("acc -7")
    {:acc, -7}
  """
  def parse_instruction(str) do
    [cmd_str, number_str] = String.split(str, " ")
    {String.to_atom(cmd_str), String.to_integer(number_str)}
  end

  @doc """
  Change one instruction at a time in a chain of instructions to produce several new chain of instructions

    iex> instructions =  [{:acc, 1}, {:jmp, 4}, {:jmp, 2}, {:acc, 2}]
    iex> Day8.swap_instruction(instructions, :jmp, :nop)
    [[{:acc, 1}, {:nop, 4}, {:jmp, 2}, {:acc, 2}], [{:acc, 1}, {:jmp, 4}, {:nop, 2}, {:acc, 2}]]
  """
  def swap_instruction(_instructions, :jmp, :nop) do

  end


end
