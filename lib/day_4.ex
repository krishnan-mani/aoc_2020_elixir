defmodule Day4 do

  @doc """
  Parses passport line broken over multiple lines
  """
  def parse_passport(str) do
    elements = str
               |> String.split(" ")
               |> Enum.map(fn x -> String.split(x, "\n") end)
               |> List.flatten
               |> Enum.map(&String.trim/1)
    Map.new(Enum.map(elements, fn x ->
      [key_str, value_str] = String.split(x, ":")
      value = if String.ends_with?(key_str, "yr") do String.to_integer(value_str) else value_str end
      {String.to_atom(key_str), value}
    end))
  end

  @doc """
  Validates passport
    iex> valid_passport = %{ecl: "gry", pid: "860033327", eyr: 2020, hcl: "#fffffd", byr: 1937, iyr: 2017, cid: "147", hgt: "183cm"}
    iex> Day4.valid_passport?(valid_passport)
    true
  """
  def valid_passport?(passport) do
    missing_required_fields = Enum.filter([:eyr, :iyr, :byr, :hgt, :hcl, :ecl, :pid, :cid],
      fn field -> !Map.has_key?(passport, field) end)
    case missing_required_fields do
      [] -> true
      [:cid] -> true
      _ -> false
    end
  end

  @doc """
  Validates birth year
    iex> Day4.valid_birth_year?(1920)
    true
    iex> Day4.valid_birth_year?(2003)
    false
  """
  def valid_birth_year?(year) do valid_year?(year, 1920, 2002) end
  def valid_issue_year?(year) do valid_year?(year, 2010, 2020) end
  def valid_expiration_year?(year) do valid_year?(year, 2020, 2030) end
  defp valid_year?(year, lower, upper) do
    unless year < lower or year > upper do true else false end
  end

end