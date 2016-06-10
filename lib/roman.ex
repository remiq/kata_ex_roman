defmodule Roman do

  def to_roman(int) when is_integer(int), do: to_roman(int, "")

  def to_roman(int, acc) when int <= 0, do: acc
  def to_roman(int, acc) when int >= 50, do: to_roman(int - 50, acc <> "L")
  def to_roman(int, acc) when int >= 40, do: to_roman(int - 40, acc <> "XL")
  def to_roman(int, acc) when int >= 10, do: to_roman(int - 10, acc <> "X")
  def to_roman(int, acc) when int >= 9, do: to_roman(int - 9, acc <> "IX")
  def to_roman(int, acc) when int >= 5, do: to_roman(int - 5, acc <> "V")
  def to_roman(int, acc) when int >= 4, do: to_roman(int - 4, acc <> "IV")
  def to_roman(int, acc) when int >= 1, do: to_roman(int - 1, acc <> "I")
  # rest is the same

  def from_roman(roman), do: from_roman(String.reverse(roman), 0, "")

  #def from_roman(roman, acc, last)
  def from_roman("", acc, _), do: acc
  def from_roman("I" <> rest, acc, "V"), do: from_roman(rest, acc - 1, "I")
  def from_roman("I" <> rest, acc, "X"), do: from_roman(rest, acc - 1, "I")
  def from_roman("I" <> rest, acc, _), do: from_roman(rest, acc + 1, "I")
  def from_roman("V" <> rest, acc, _), do: from_roman(rest, acc + 5, "V")
  def from_roman("X" <> rest, acc, "L"), do: from_roman(rest, acc - 10, "X")
  def from_roman("X" <> rest, acc, _), do: from_roman(rest, acc + 10, "X")
  def from_roman("L" <> rest, acc, _), do: from_roman(rest, acc + 50, "L")

end
