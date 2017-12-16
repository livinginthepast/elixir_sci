defmodule Sci.ListTest do
  use ExUnit.Case, async: true
  doctest Sci.List

  import Sci.Helpers.Sigils

  describe "div/2" do
    alias Sci.List, as: L

    test "raises if the length of the lists are not equal" do
      assert_raise RuntimeError, "lists must be equal in length", fn ->
        L.div [1], [2, 3]
      end
    end

    test "divides one list by another list" do
      assert [0.5, 0.25, 3] == L.div([1, 2, 3], [2, 8, 1])
    end

    test "divides lists of complex numbers" do
      expected = [~i{0.5+0.5i}, ~i{0.24615384615384617-0.03076923076923077i}]
      assert expected == L.div([~i{1+1i}, 2], [2, ~i{8+1i}])
    end
  end

  describe "prod/1" do
    import Sci.List, only: [prod: 1]

    test "is 1 for an empty list" do
      assert 1 == prod([])
    end

    test "is the product of a set of numbers" do
      assert 24 == prod([2, 3, 4])
    end

    test "can multiply complex numbers" do
      assert ~i{24+60i} == prod([~i{2+5i}, 3, 4])
    end

    test "returns a real number when all complex numbers resolve to 0" do
      assert 24 == prod([~i{2+0i}, 3, 4])
    end

    test "returns the product of N-dimensional lists" do
      assert 48 == prod([[3, 4], [2, 2]])
    end
  end
end
