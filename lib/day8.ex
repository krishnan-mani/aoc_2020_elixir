defmodule Day8 do
  @moduledoc false

  @doc """
  given the instruction index, and the accumulator,
  returns the next instruction index and accumulator for different instructions

    iex> Day8.process(:nop, 12, 7)
    %{index: 13, acc: 7}
    iex> Day8.process({:jmp, 4}, 12, 7)
    %{index: 16, acc: 7}
    iex> Day8.process({:acc, 2}, 12, 7)
    %{index: 13, acc: 9}
  """
  def process(:nop, index, acc), do: %{index: index + 1, acc: acc}
  def process({:jmp, jump_by}, index, acc), do: %{index: index + jump_by, acc: acc}
  def process({:acc, inc_by}, index, acc), do: %{index: index + 1, acc: acc + inc_by}

  @doc """
  Process instructions until loop

    iex> no_loop_instructions = [{:acc, 1}, :nop, {:jmp, 2}, :nop, :nop, {:acc, 2}]
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

    iex> Day8.parse_instruction("nop +0")
    :nop
    iex> Day8.parse_instruction("jmp +12")
    {:jmp, 12}
    iex> Day8.parse_instruction("acc -7")
    {:acc, -7}
  """
  def parse_instruction(str) do
    number = String.split(str, " ")
             |> List.last()
             |> String.to_integer()
    case String.slice(str, 0, 3) do
      "nop" -> :nop
      "jmp" -> {:jmp, number}
      "acc" -> {:acc, number}
    end
  end

end
