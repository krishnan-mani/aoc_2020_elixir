defmodule Day9Test do
  use ExUnit.Case, async: true
  doctest Day9

  describe "parse numbers" do
    setup do
      number_strings = """
            35
            20
            15
            25
            47
            40
            62
            55
            65
            95
            102
            117
            150
            182
            127
            219
            299
            277
            309
            576
      """
      numbers = number_strings
                |> String.split("\n")
                |> Stream.map(&String.trim/1)
                |> Stream.reject(fn x -> String.length(x) == 0 end)
                |> Enum.map(&String.to_integer/1)
      %{numbers: numbers}
    end

    test "finds first invalid number", %{numbers: numbers} do
      assert 127 == Day9.first_invalid_number(numbers, 5)
    end

    test "finds sequence that adds up to invalid number", %{numbers: numbers} do
      assert [15, 25, 47, 40] = Day9.adds_up(numbers, 127)
    end
  end

end
