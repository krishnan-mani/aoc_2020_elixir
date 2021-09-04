defmodule Day7 do
  @moduledoc false

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

end


