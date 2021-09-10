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
    {3, :no_loop}
    iex> loop_instructions = [{:acc, 1}, {:jmp, 4}, {:jmp, 2}, {:nop, 1}, {:nop, 2}, {:jmp, -4}]
    iex> Day8.process_instructions(loop_instructions)
    {1, :loop}
  """
  def process_instructions(instructions, index \\ 0, acc \\ 0, processed \\ []) do
    if index in processed do
      {acc, :loop}
    else
      case Enum.at(instructions, index, :none) do
        :none -> {acc, :no_loop}
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
    iex> Day8.swap_instruction(instructions, 1, :jmp, :nop)
    [{:acc, 1}, {:nop, 4}, {:jmp, 2}, {:acc, 2}]
    iex> Day8.swap_instruction(instructions, 1, :acc, :nop)
    [{:acc, 1}, {:jmp, 4}, {:jmp, 2}, {:acc, 2}]
    iex> Day8.swap_instruction([{:acc, 1}, {:nop, 4}, {:jmp, 2}, {:acc, 2}], 1, :nop, :jmp)
    instructions
  """
  def swap_instruction(instructions, index, original, replacement) do
    {cmd, num} = Enum.at(instructions, index)
    case cmd do
      ^original -> List.replace_at(instructions, index, {replacement, num})
      _ -> instructions
    end
  end

  @doc """
  mutate one instruction to another in a sequence of instructions and check whether it terminates

  """
  def mutated_terminates?(instructions, index \\ 0, swap_fn, test_fn, original, replacement) do
    mutated_instructions = swap_fn.(instructions, index, original, replacement)
    case test_fn.(mutated_instructions) do
      {_, :loop} when index < length(instructions) ->
        mutated_terminates?(instructions, index + 1, swap_fn, test_fn, original, replacement)
      {acc, :no_loop} ->
        acc
      _ ->
        false
    end
  end

end
