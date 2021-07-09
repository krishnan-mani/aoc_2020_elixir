defmodule Day3Test do
  use ExUnit.Case, async: true
  use ExUnit.Parameterized
  doctest Day3

  describe "For the given landscape" do
    setup do
      grid = [
        "..##.........##.........##.........##.........##.........##.......",
        "#...#...#..#...#...#..#...#...#..#...#...#..#...#...#..#...#...#..",
        ".#....#..#..#....#..#..#....#..#..#....#..#..#....#..#..#....#..#.",
        "..#.#...#.#..#.#...#.#..#.#...#.#..#.#...#.#..#.#...#.#..#.#...#.#",
        ".#...##..#..#...##..#..#...##..#..#...##..#..#...##..#..#...##..#.",
        "..#.##.......#.##.......#.##.......#.##.......#.##.......#.##.....",
        ".#.#.#....#.#.#.#....#.#.#.#....#.#.#.#....#.#.#.#....#.#.#.#....#",
        ".#........#.#........#.#........#.#........#.#........#.#........#",
        "#.##...#...#.##...#...#.##...#...#.##...#...#.##...#...#.##...#...",
        "#...##....##...##....##...##....##...##....##...##....##...##....#",
        ".#..#...#.#.#..#...#.#.#..#...#.#.#..#...#.#.#..#...#.#.#..#...#.#"
      ]
      {:ok, %{grid: grid}}
    end

    test_with_params "following different slopes; one counts the expected number of trees, advancing down one at a time", context,
                     fn (grid, slope, expected) ->
                       assert Day3.count_trees(grid, slope) == expected
                     end
      do
      [
        {context.grid, %{right: 1, down: 1}, 2},
        {context.grid, %{right: 3, down: 1}, 7},
        {context.grid, %{right: 5, down: 1}, 3},
        {context.grid, %{right: 7, down: 1}, 4},
      ]
    end

    test "count trees, advancing two rows at a time", %{grid: grid} do
      slope = %{right: 1, down: 2}
      assert Day3.count_trees(grid, slope) == 2
    end

  end

end