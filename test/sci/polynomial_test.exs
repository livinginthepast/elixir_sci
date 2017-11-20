defmodule Sci.PolynomialTest do
  use ExUnit.Case

  import Sci.Helpers.Sigils

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
        ~n{-0.04544+0.66722i},
        ~n{-0.03267+0.19871i},
        ~n{-0.03267-0.19871i},
        ~n{-0.04544-0.66722i},
      ]

      expected_output = [
        ~n{1},
        ~n{0.15622-1.1102230246251565e-16i},
        ~n{0.4937384142000001-6.938893903907228e-18i},
        ~n{0.032908596023320004+3.469446951953614e-18i},
        ~n{0.018137217518334747+4.336808689942018e-19i},
      ]

      assert expected_output == poly(set)
    end

    test "returns real numbers when all imaginary parts are 0" do
      set = [
        ~n{-0.04544},
        ~n{-0.03267},
        ~n{-0.03267},
        ~n{-0.04544},
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
