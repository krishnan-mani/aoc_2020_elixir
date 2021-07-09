defmodule Day4Test do
  use ExUnit.Case
  use ExUnit.Parameterized
  doctest Day4

  describe "parses password fields broken over multiple lines" do
    test "for one or more lines" do
      password_lines = "ecl:gry pid:860033327 eyr:2020 hcl:#fffffd\nbyr:1937 iyr:2017 cid:147 hgt:183cm"
      assert Day4.parse_password(password_lines) == %{ecl: "gry", pid: "860033327", eyr: 2020, hcl: "#fffffd", byr: 1937, iyr: 2017, cid: "147", hgt: "183cm"}
    end
  end

  test_with_params "valid and invalid passwords",
    fn (password, expected)  -> assert Day4.valid_password?(password) == expected end
    do
    [
      {Day4.parse_password("ecl:gry pid:860033327 eyr:2020 hcl:#fffffd\nbyr:1937 iyr:2017 cid:147 hgt:183cm"), true},
      {Day4.parse_password("iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884\nhcl:#cfa07d byr:1929"), false},
      {Day4.parse_password("hcl:#ae17e1 iyr:2013\neyr:2024\necl:brn pid:760753108 byr:1931\nhgt:179cm"), true},
      {Day4.parse_password("hcl:#cfa07d eyr:2025 pid:166559648\niyr:2011 ecl:brn hgt:59in"), false}
    ]
  end

end