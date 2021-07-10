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
  Validates passport fields fully
    iex> valid_passport = Day4.parse_passport("pid:087499704 hgt:74in ecl:grn iyr:2012 eyr:2030 byr:1980 hcl:#623a2f")
    iex> Day4.fully_valid_passport?(valid_passport)
    true
    iex> invalid_passport = Day4.parse_passport("eyr:1972 cid:100 hcl:#18171d ecl:amb hgt:170 pid:186cm iyr:2018 byr:1926")
    iex> Day4.fully_valid_passport?(invalid_passport)
    false
  """
  def fully_valid_passport?(passport) do
    unless Day4.valid_passport?(passport) do
      false
    else
      Enum.all?(passport, fn {key, value} ->
        case key do
          :byr -> valid_birth_year?(value)
          :iyr -> valid_issue_year?(value)
          :eyr -> valid_expiration_year?(value)
          :hgt -> valid_height?(value)
          :hcl -> valid_hair_color?(value)
          :ecl -> valid_eye_color?(value)
          :pid -> valid_passport_ID?(value)
          :cid -> true
          _ -> false
        end
      end)
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
  defp valid_year?(year, lower, upper) when year < lower or year > upper do false end
  defp valid_year?(_year, _lower, _upper) do true end

  @doc """
  Validate height
  #  hgt (Height) - a number followed by either cm or in:
  #  If cm, the number must be at least 150 and at most 193.
  #  If in, the number must be at least 59 and at most 76.
    iex> Day4.valid_height?("150cm")
    true
  """
  def valid_height?(height_str) do
    unit = case String.slice(height_str, -2, 2) do
      "cm" -> :cm
      "in" -> :in
      _ -> :unknown
    end
    value = String.slice(height_str, 0..-3//1) |> String.to_integer
    case unit do
      :unknown -> false
      :cm -> value >= 150 && value <= 193
      :in -> value >= 59 && value <= 76
    end
  end

  @doc """
  Validate hair colour
  # hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
    iex> Day4.valid_hair_color?("#123abc")
    true
    iex> Day4.valid_hair_color?("#123abz")
    false
    iex> Day4.valid_hair_color?("123abc")
    false
  """
  def valid_hair_color?(hair_color_str) do
    case String.split(hair_color_str, "#") do
      ["", value] ->
        if String.length(value) == 6 do
          allowed_chars = [?0, ?1, ?2, ?3, ?4, ?5, ?6, ?7, ?8, ?9, ?a, ?b, ?c, ?d, ?e, ?f]
          Enum.all?(String.to_charlist(value), fn x -> Enum.member?(allowed_chars, x) end)
        else
          false
        end
      _ -> false
    end
  end

  @doc """
  Validate eye color
  # ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
    iex> Day4.valid_eye_color?("amb")
    true
    iex> Day4.valid_eye_color?("wat")
    false
  """
  def valid_eye_color?(eye_color_str) do
    Enum.member?(["amb", "blu", "brn", "gry", "grn", "hzl", "oth"], eye_color_str)
  end

  @doc """
  Validate passport ID
    iex> Day4.valid_passport_ID?("000000001")
    true
    iex> Day4.valid_passport_ID?("0123456789")
    false
  """
  def valid_passport_ID?(pid) do
    if String.length(pid) == 9 do
      case Integer.parse(pid) do
        :error -> false
        _ -> true
      end
    else
      false
    end
  end

end