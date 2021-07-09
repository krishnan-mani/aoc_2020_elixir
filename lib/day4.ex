defmodule Day4 do

  @doc """
  Parses password line broken over multiple lines
"""
  def parse_password(str) do
    elements = str
               |> String.split(" ")
               |> Enum.map(fn x -> String.split(x, "\n") end)
               |> List.flatten
               |> Enum.map(&String.trim/1)
    Map.new(Enum.map(elements, fn x ->
      [key_str, value_str] = String.split(x, ":")
      value = case String.ends_with?(key_str, "yr") do
        true -> String.to_integer(value_str)
        _ -> value_str
      end
      {String.to_atom(key_str), value}
    end))
  end

  @doc """
  Validates password
    iex> valid_password = %{ecl: "gry", pid: "860033327", eyr: 2020, hcl: "#fffffd", byr: 1937, iyr: 2017, cid: "147", hgt: "183cm"}
    iex> Day4.valid_password?(valid_password)
    true
  """
  def valid_password?(password) do
    missing_required_fields = Enum.filter([:eyr, :iyr, :byr, :hgt, :hcl, :ecl, :pid, :cid],
      fn field -> !Map.has_key?(password, field) end)
    case missing_required_fields do
      [] -> true
      [:cid] -> true
      _ -> false
    end
  end

end