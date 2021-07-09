defmodule Day4 do

  @doc """
  Parses password string into representation as fields and values

    iex> Day4.parse_password("ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
    ...> byr:1937 iyr:2017 cid:147 hgt:183cm")
    %{ecl: "gry", pid: "860033327", eyr: 2020, hcl: "#fffffd", byr: 1937, iyr: 2017, cid: "147", hgt: "183cm"}
  """
  def parse_password(str) do
    elements = str |> String.split(" ") |> Enum.map(&String.trim/1)
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
  iex> first_valid_password_entry = Day4.parse_password("ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
  ...> byr:1937 iyr:2017 cid:147 hgt:183cm")
  iex> Day4.valid_password?(first_valid_password_entry)
  true
  iex> second_invalid_password_entry = Day4.parse_password("iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
  ...> hcl:#cfa07d byr:1929")
  iex> Day4.valid_password?(second_invalid_password_entry)
  false
"""
  def valid_password?(password) do
    Enum.all?([:eyr, :iyr, :byr, :hgt, :hcl, :ecl, :pid, :cid],
      fn field -> Map.has_key?(password, field) end)
  end

end
