defmodule Day7Test do
  use ExUnit.Case, async: true
  doctest Day7

  describe "parse bag rules" do
    test "builds up a model of bag colours and colours they can contain" do
      model = Day7.process_rule("light red bags contain 1 bright white bag, 2 muted yellow bags.", %{})
      assert model == %{"light red" => ["bright white", "muted yellow"]}

      model = Day7.process_rule("dark orange bags contain 3 bright white bags, 4 muted yellow bags.", model)
      assert model == %{
               "dark orange" => ["bright white", "muted yellow"],
               "light red" => ["bright white", "muted yellow"]
             }

      model = Day7.process_rule("bright white bags contain 1 shiny gold bag.", model)
      assert model == %{
               "bright white" => ["shiny gold"],
               "dark orange" => ["bright white", "muted yellow"],
               "light red" => ["bright white", "muted yellow"]
             }

      model = Day7.process_rule("faded blue bags contain no other bags.", model)
      assert model == %{
               "faded blue" => [],
               "bright white" => ["shiny gold"],
               "dark orange" => ["bright white", "muted yellow"],
               "light red" => ["bright white", "muted yellow"]
             }
    end
  end

  describe "parse bag rules with counts" do
    setup do
      rules = """
      light red bags contain 1 bright white bag, 2 muted yellow bags.
      dark orange bags contain 3 bright white bags, 4 muted yellow bags.
      bright white bags contain 1 shiny gold bag.
      muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
      shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
      dark olive bags contain 3 faded blue bags, 4 dotted black bags.
      vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
      faded blue bags contain no other bags.
      dotted black bags contain no other bags.
      """

      more_rules = """
      shiny gold bags contain 2 dark red bags.
      dark red bags contain 2 dark orange bags.
      dark orange bags contain 2 dark yellow bags.
      dark yellow bags contain 2 dark green bags.
      dark green bags contain 2 dark blue bags.
      dark blue bags contain 2 dark violet bags.
      dark violet bags contain no other bags.
      """

      %{rules: rules, more_rules: more_rules}
    end

    test "builds up a model of bag colours and number of other bags they contain", %{rules: rules} do
      model = rules
              |> String.split("\n")
              |> Stream.map(&String.trim/1)
              |> Stream.reject(fn str -> String.length(str) == 0 end)
              |> Enum.reduce(%{}, fn rule, acc -> Day7.process_bag_counts(rule, acc) end)

      assert model == %{
               "bright white" => [{"shiny gold", 1}],
               "dark olive" => [{"faded blue", 3}, {"dotted black", 4}],
               "dark orange" => [{"bright white", 3}, {"muted yellow", 4}],
               "dotted black" => [],
               "faded blue" => [],
               "light red" => [{"bright white", 1}, {"muted yellow", 2}],
               "muted yellow" => [{"shiny gold", 2}, {"faded blue", 9}],
               "shiny gold" => [{"dark olive", 1}, {"vibrant plum", 2}],
               "vibrant plum" => [{"faded blue", 5}, {"dotted black", 6}]
             }
    end

    test "counts bags contained" do
      model = %{
        "bright white" => [{"shiny gold", 1}],
        "dark olive" => [{"faded blue", 3}, {"dotted black", 4}],
        "dark orange" => [{"bright white", 3}, {"muted yellow", 4}],
        "dotted black" => [],
        "faded blue" => [],
        "light red" => [{"bright white", 1}, {"muted yellow", 2}],
        "muted yellow" => [{"shiny gold", 2}, {"faded blue", 9}],
        "shiny gold" => [{"dark olive", 1}, {"vibrant plum", 2}],
        "vibrant plum" => [{"faded blue", 5}, {"dotted black", 6}]
      }
      assert 32 == Day7.count_bags("shiny gold", model) - 1
    end

    test "process rules and count bags contained in shiny gold bag", %{more_rules: more_rules} do
      model = more_rules
              |> String.split("\n")
              |> Stream.map(&String.trim/1)
              |> Stream.reject(fn str -> String.length(str) == 0 end)
              |> Enum.reduce(%{}, fn rule, acc -> Day7.process_bag_counts(rule, acc) end)

      assert 126 == Day7.count_bags("shiny gold", model) - 1
    end

    test "finds both bags that can directly and indirectly contain shiny gold bags", %{rules: rules} do
      model = rules
              |> String.split("\n")
              |> Stream.map(&String.trim/1)
              |> Stream.reject(fn str -> String.length(str) == 0 end)
              |> Enum.reduce(%{}, fn rule, acc -> Day7.process_rule(rule, acc) end)

      assert model == %{
               "bright white" => ["shiny gold"],
               "dark olive" => ["faded blue", "dotted black"],
               "dark orange" => ["bright white", "muted yellow"],
               "dotted black" => [],
               "faded blue" => [],
               "light red" => ["bright white", "muted yellow"],
               "muted yellow" => ["shiny gold", "faded blue"],
               "shiny gold" => ["dark olive", "vibrant plum"],
               "vibrant plum" => ["faded blue", "dotted black"]
             }

      assert Day7.count_container_colours(model) == 4
    end
  end

end
