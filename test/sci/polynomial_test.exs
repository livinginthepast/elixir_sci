defmodule Sci.PolynomialTest do
  use ExUnit.Case

  import Test.ComplexHelpers

  describe "poly/1" do
    import Sci.Polynomial, only: [poly: 1]

    test "is 1 for an empty set" do
      assert [1] == poly([])
    end

    test "for a list, finds the coefficients of the polynomial whose roots are the elements of the list" do
      assert [1, -6, 11, -6] == poly([1, 2, 3])
    end

    test "finds the polynomial coefficients for a list of complex numbers" do
      set = [
        complex(r: -0.04544, i: 0.66722),
        complex(r: -0.03267, i: 0.19871),
        complex(r: -0.03267, i: -0.19871),
        complex(r: -0.04544, i: -0.66722),
      ]

      expected_output = [
        complex(r: 1),
        complex(r: 0.15622, i: -1.1102230246251565e-16),
        complex(r: 0.4937384142000001, i: -6.938893903907228e-18),
        complex(r: 0.032908596023320004, i: 3.469446951953614e-18),
        complex(r: 0.018137217518334747, i: 4.336808689942018e-19),
      ]

      assert expected_output == poly(set)
    end

    test "returns real numbers when all imaginary parts are 0" do
      set = [
        complex(r: -0.04544),
        complex(r: -0.03267),
        complex(r: -0.03267),
        complex(r: -0.04544),
      ]

      expected_output = [
        1,
        0.15622,
        0.009070221699999999,
        2.31912464256e-4,
        2.20381388181504e-6,
      ]

      assert expected_output == poly(set)
    end

    @tag :skip
    test "for an N-by-N matrix, finds a row vector of coefficients" do
      # assert poly([1, 2], [3, 4]] == {[1, -5, -2], sqrt (eps)}
    end
  end
end
