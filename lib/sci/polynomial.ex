defmodule Sci.Polynomial do
  @moduledoc """
  Helper functions for dealing with polynomials.
  """

  alias Sci.Polynomial

  @doc """
  Finds the coefficients of a polynomial with the given sequence of roots.

  ## Examples

      iex> Sci.Polynomial.poly([0, 0, 0])
      [1, 0, 0, 0]

      iex> Sci.Polynomial.poly([1, 2, 3])
      [1, -6, 11, -6]

      iex> import Sci.Helpers.Sigils
      iex> Sci.Polynomial.poly([~n{1-1i}, ~n{2-1i}, ~n{3-1i}])
      [ComplexNum.new(1), ComplexNum.new(-6, 3), ComplexNum.new(8, -12), ComplexNum.new(0, 10)]

  """
  def poly(set) when is_list(set), do: Polynomial.Poly.poly(set)
end

