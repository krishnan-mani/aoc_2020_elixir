defmodule Day7 do
  @moduledoc false

  @count """
  Count all bags in model
  """
  def total_bag_count(model) do
    Enum.reduce(model, 0, fn {colour, _}, acc -> acc + Day7.count_bags(colour, model) end)
  end

  @doc """
  Count bags in model for colour

    iex> Day7.count_bags("dotted_black", %{"dotted black" => []})
    1
    iex> Day7.count_bags("bright white", %{"bright white" => [{"shiny gold", 3}], "shiny gold" => []})
    4
  """
  def count_bags(colour, model) do
    sub_colours = Map.get(model, colour, [])
    1 + Enum.reduce(sub_colours, 0, fn {sub_colour, count}, acc -> acc + (count * count_bags(sub_colour, model)) end)
  end

  @doc """
  Count bags that can eventually contain shiny gold bags
  """
  def count_container_colours(model, colour \\ "shiny gold") do
    Enum.count(model, fn {container_colour, _} -> Day7.contains_colour?(container_colour, model, colour) end)
  end

  @doc """
  Establishes whether a bag can directly contain another

    iex> model = %{"bright white" => ["shiny gold"]}
    iex> Day7.contains_colour?("bright white", model)
    true
  """
  def contains_colour?(container_colour, model, contained_colour \\ "shiny gold") do
    sub_colours = Map.get(model, container_colour)
    (contained_colour in sub_colours) or Enum.any?(sub_colours, fn colour -> contains_colour?(colour, model, contained_colour) end)
  end

  @doc """
  Read rule and construct model for bags that contain other bags

    iex> light_red_rule = "light red bags contain 1 bright white bag, 2 muted yellow bags."
    iex> Day7.process_bag_counts(light_red_rule, %{})
    %{"light red" => [{"bright white", 1}, {"muted yellow", 2}]}
  """
  def process_bag_counts(rule, model) do
    [container_str, contained_str] = String.split(rule, " contain ")
    container_colour = Day7.read_container_colour(container_str)
    contained_bag_counts = case String.starts_with?(contained_str, "no") do
      true -> []
      false -> contained_str
               |> String.split(",")
               |> Enum.map(&Day7.read_contained_bag_count/1)
    end
    Map.put(model, container_colour, contained_bag_counts)
  end

  @doc """
  Read rule and construct model for bags that contain other bags

    iex> light_red_rule = "light red bags contain 1 bright white bag, 2 muted yellow bags."
    iex> Day7.process_rule(light_red_rule, %{})
    %{"light red" => ["bright white", "muted yellow"]}
  """
  def process_rule(rule, model) do
    [container_str, contained_str] = String.split(rule, " contain ")
    container_colour = Day7.read_container_colour(container_str)
    content_colours = case String.starts_with?(contained_str, "no") do
      true -> []
      false -> contained_str
               |> String.split(",")
               |> Enum.map(&Day7.read_contained_colour/1)
    end
    Map.put(model, container_colour, content_colours)
  end

  @doc """
  Read container colour from string

    iex> Day7.read_container_colour("light red bags ")
    "light red"
  """
  def read_container_colour(str) do
    str
    |> String.split(" bags")
    |> List.first()
  end

  @doc """
  Read contained colour from string

    iex> Day7.read_contained_colour("1 bright white bag")
    "bright white"
    iex> Day7.read_contained_colour(" 2 muted yellow bags")
    "muted yellow"
  """
  def read_contained_colour(str) do
    str
    |> String.split(" bag")
    |> List.first()
    |> String.trim()
    |> String.slice(2..-1//1)
  end

  @doc """
    Read count of contained bags by colour

    iex> Day7.read_contained_bag_count("1 bright white bag")
    {"bright white", 1}
    iex> Day7.read_contained_bag_count(" 2 muted yellow bags")
    {"muted yellow", 2}
    iex> Day7.read_contained_bag_count(" no other bags.")
    {}
  """
  def read_contained_bag_count(str) do
    [count_str | colour_str] = str |> String.trim() |> String.split(" ")
    case count_str do
      "no" -> {}
       _ -> count = String.to_integer(count_str)
                  [hue, shade | _] = colour_str
                   colour = "#{hue} #{shade}"
                   {colour, count}
    end
  end

end


