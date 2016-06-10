defmodule Roman do

  @doc """
  Obvious, pattern-matching way.
  """
  def to_roman(int) when is_integer(int), do: to_roman(int, "")

  defp to_roman(int, acc) when int <= 0, do: acc
  defp to_roman(int, acc) when int >= 50, do: to_roman(int - 50, acc <> "L")
  defp to_roman(int, acc) when int >= 40, do: to_roman(int - 40, acc <> "XL")
  defp to_roman(int, acc) when int >= 10, do: to_roman(int - 10, acc <> "X")
  defp to_roman(int, acc) when int >= 9, do: to_roman(int - 9, acc <> "IX")
  defp to_roman(int, acc) when int >= 5, do: to_roman(int - 5, acc <> "V")
  defp to_roman(int, acc) when int >= 4, do: to_roman(int - 4, acc <> "IV")
  defp to_roman(int, acc) when int >= 1, do: to_roman(int - 1, acc <> "I")
  # rest is the same

  @doc """
  Pattern-matching with macro.
  Easier to add/modify cases, but seems less clear.
  """
  def to_roman_macro(int), do: to_roman_macro(int, "")
  def to_roman_macro(int, acc) when int <= 0, do: acc
  [
    {50, "L"},
    {40, "XL"},
    {10, "X"},
    {9, "IX"},
    {5, "V"},
    {4, "IV"},
    {1, "I"},
  ] |> Enum.each(fn {value, char} ->
    def to_roman_macro(int, acc) when int >= unquote(value), do: to_roman_macro(int - unquote(value), acc <> unquote(char))
  end)

  @step1_replacement [
    {50, "L"},
    {10, "X"},
    {5, "V"},
    {1, "I"}
  ]
  @step2_replacement [
    {"XXXX", "XL"},
    {"VIIII", "IX"},
    {"IIII", "IV"}
  ]

  @doc """
  Two step (expand, reduce) method described here:
  http://www.sandimetz.com/blog/2016/6/9/make-everything-the-same
  https://github.com/skmetz/play/blob/master/roman_numerals/roman_numerals_medium.rb

  Pattern-matching seems more elegant.
  """
  def to_roman_2step(int) do
    # step 1: expand
    {0, expanded} = Enum.reduce(@step1_replacement, {int, ""}, fn {val, c}, {rest, acc} ->
      {rem(rest, val), acc <> String.duplicate(c, div(rest, val))}
    end)
    # step 2: reduce
    Enum.reduce(@step2_replacement, expanded, fn {from, to}, str ->
      String.replace(str, from, to)
    end)
  end

  def from_roman(roman), do: from_roman(String.reverse(roman), 0, "")

  #defp from_roman(roman, acc, last)
  defp from_roman("", acc, _), do: acc
  defp from_roman("I" <> rest, acc, "V"), do: from_roman(rest, acc - 1, "I")
  defp from_roman("I" <> rest, acc, "X"), do: from_roman(rest, acc - 1, "I")
  defp from_roman("I" <> rest, acc, _), do: from_roman(rest, acc + 1, "I")
  defp from_roman("V" <> rest, acc, _), do: from_roman(rest, acc + 5, "V")
  defp from_roman("X" <> rest, acc, "L"), do: from_roman(rest, acc - 10, "X")
  defp from_roman("X" <> rest, acc, _), do: from_roman(rest, acc + 10, "X")
  defp from_roman("L" <> rest, acc, _), do: from_roman(rest, acc + 50, "L")

end
