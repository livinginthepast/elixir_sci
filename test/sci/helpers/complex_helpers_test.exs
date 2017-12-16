defmodule Sci.Helpers.ComplexHelpersTest do
  use Sci.TestCase, async: true
  doctest Sci.Helpers.ComplexHelpers

  alias Sci.Helpers.ComplexHelpers, as: CH

  describe "real?/1" do
    test "is true for real numeric types" do
      assert CH.real?(1345)
      assert CH.real?(-1345)
      assert CH.real?(0.345)
      assert CH.real?(-0.345)
    end

    test "is true for a set of real numeric types" do
      assert CH.real?([1, 3, 5, 0.45, -1234, -0.3452])
    end

    test "is true for a complex number with a 0 imaginary component" do
      assert CH.real?(ComplexNum.new(122345, 0))
    end

    test "is true for a set of complex numbers with 0 imaginary components" do
      assert CH.real?([ComplexNum.new(122345, 0), ComplexNum.new(0.1234, 0)])
    end

    test "is false for a complex number" do
      refute CH.real?(ComplexNum.new(1, 1))
    end

    test "is false for a set with a complex number" do
      refute CH.real?([1, 2, 4, ComplexNum.new(1, 1)])
    end
  end
end
