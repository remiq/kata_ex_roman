defmodule RomanTest do
  use ExUnit.Case
  doctest Roman

  test "all" do
    assert 1 + 1 == 2
    data = [
    {1, 	"I"},
    {4, 	"IV"},
    {5, 	"V"},
    {6, 	"VI"},
    {7, 	"VII"},
    {8, 	"VIII"},
    {9, 	"IX"},
    {10, 	"X"},
    {11, 	"XI"},
    {14, 	"XIV"},
    {15, 	"XV"},
    {16, 	"XVI"},
    {38, 	"XXXVIII"},
    {39, 	"XXXIX"},
    {40, 	"XL"},
    {41, 	"XLI"},
    {49, 	"XLIX"}, # interesting
    {50, 	"L"},
    {51, 	"LI"},
    ]
    Enum.each(data, fn {i, r} ->
      assert r == Roman.to_roman(i)
      assert i == Roman.from_roman(r)
    end)
  end
end
