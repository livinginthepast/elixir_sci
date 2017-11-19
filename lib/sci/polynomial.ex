defmodule Sci.Polynomial do

  alias Sci.Polynomial

  @doc """
  Finds the coefficients of a polynomial with the given sequence of roots.
  """
  def poly(set) when is_list(set), do: Polynomial.Poly.poly(set)
end

