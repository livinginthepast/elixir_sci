defmodule Sci.ListTest do
  use ExUnit.Case, async: true
  doctest Sci.List

  import Sci.Helpers.Sigils

  describe "prod/1" do
    import Sci.List, only: [prod: 1]

    test "is 1 for an empty list" do
      assert 1 == prod([])
    end

    test "is the product of a set of numbers" do
      assert 24 == prod([2, 3, 4])
    end

    test "can multiply complex numbers" do
      assert ~n{24+60i} == prod([~n{2+5i}, 3, 4])
    end

    test "returns a real number when all complex numbers resolve to 0" do
      assert 24 == prod([~n{2+0i}, 3, 4])
    end

    test "returns the product of N-dimensional lists" do
      assert 48 == prod([[3, 4], [2, 2]])
    end
  end
end
