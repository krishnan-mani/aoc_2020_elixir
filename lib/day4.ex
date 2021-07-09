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

end
