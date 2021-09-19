defmodule Day10Test do
  use ExUnit.Case, async: true

  doctest Day10

  describe "given a bunch of adaptors" do
    setup do
      adaptor_strings = """
            16
            10
            15
            5
            1
            11
            7
            19
            6
            12
            4
      """
      adaptors = adaptor_strings
                 |> String.split("\n")
                 |> Stream.map(&String.trim/1)
                 |> Stream.reject(fn x -> String.length(x) == 0 end)
                 |> Enum.map(&String.to_integer/1)
      %{adaptors: adaptors}
    end

    test "combine them all per the constraints", %{adaptors: adaptors} do
      assert [1, 4, 5, 6, 7, 10, 11, 12, 15, 16, 19] == Day10.combine_adaptors(adaptors)
    end
  end
end