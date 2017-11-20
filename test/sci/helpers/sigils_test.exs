defmodule Sci.Helpers.SigilsTest do
  use ExUnit.Case
  doctest Sci.Helpers.Sigils, import: true

  import Sci.Helpers.Sigils

  describe "sigil_n" do
    test "matches a real number" do
      assert ~n{1} === ComplexNum.new(1)
    end

    test "matches a simple complex number" do
      assert ~n{1+2i} === ComplexNum.new(1, 2)
    end

    test "matches a negative complex number" do
      assert ~n{-1+2i} === ComplexNum.new(-1, 2)
    end

    test "matches a negative imaginary component" do
      assert ~n{-1-2i} === ComplexNum.new(-1, -2)
    end

    test "matches floats" do
      assert ~n{0.1234} === ComplexNum.new(0.1234)
      assert ~n{6.1234} === ComplexNum.new(6.1234)
      assert ~n{0.1234e-12} === ComplexNum.new(0.1234e-12)
    end

    test "matches float imaginary components" do
      assert ~n{0.1234+0.2345i} === ComplexNum.new(0.1234, 0.2345)
      assert ~n{0.1234+1.2345i} === ComplexNum.new(0.1234, 1.2345)
      assert ~n{0.1234-0.2345e-12i} === ComplexNum.new(0.1234, -0.2345e-12)
    end

    test "does not allow spaces" do
      assert_raise RuntimeError, "Unable to match complex number of format ~n{0.123±01245i}", fn ->
        ~n{0.1 - 0.22345i}
      end
    end

    test "raises when passed a random string" do
      assert_raise RuntimeError, "Unable to match complex number of format ~n{0.123±01245i}", fn ->
        ~n{blah blah balh}
      end
    end
  end
end
