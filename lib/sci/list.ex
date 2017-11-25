defmodule Sci.List do
  @moduledoc """
  Functions for doing math on sets of numbers.
  """

  alias Numbers, as: N
  alias Sci.Helpers.ComplexHelpers, as: CH

  @doc """
  Find the product of a set of numbers.

  ## Examples

      iex> Sci.List.prod([])
      1

      iex> Sci.List.prod([1, 2, 3])
      6

      iex> import Sci.Helpers.Sigils
      iex> Sci.List.prod([~n{1+2i}, 2, 3])
      ComplexNum.new(6, 12)
  """
  def prod([]), do: 1
  def prod([head | tail]), do: N.mult(prod(head), prod(tail)) |> CH.make_real
  def prod(number), do: number

end
