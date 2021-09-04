defmodule Day7 do
  @moduledoc false

  @doc """
  Read rule and construct model for bags that contain other bags

    iex> light_red_rule = "light red bags contain 1 bright white bag, 2 muted yellow bags"
    iex> %{} |> Day7.process_rule(light_red_rule)
    %{"light red" => ["bright white", "muted yellow"]}
  """
  def process_rule(model, rule) do
    [container_str, contained_str] = String.split(rule, " contain ")
    container_colour = Day7.read_container_colour(container_str)
    content_colours = contained_str
                      |> String.split(",")
                      |> Enum.map(&Day7.read_contained_colour/1)
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


