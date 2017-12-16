defmodule Sci.List do
  @moduledoc """
  Functions for doing math on sets of numbers.
  """

  alias Numbers, as: N
  alias Sci.Helpers.ComplexHelpers, as: CH

  @doc """
  Divide a list by another list.

  ## Examples

      iex> Sci.List.div([1, 2], [2, 8])
      [0.5, 0.25]

  """
  def div(a, b) when length(a) != length(b), do: raise "lists must be equal in length"
  def div(a, b) when is_list(a) and is_list(b) do
    a |> Enum.zip(b) |> Enum.map(fn {n, d} ->
      try do
        Numbers.div(n, d)
      rescue
        e in ArithmeticError -> 0
      end
    end)
  end

  @doc """
  Find the product of a set of numbers.

  ## Examples

      iex> Sci.List.prod([])
      1

      iex> Sci.List.prod([1, 2, 3])
      6

      iex> import Sci.Helpers.Sigils
      iex> Sci.List.prod([~i{1+2i}, 2, 3])
      ComplexNum.new(6, 12)

  """
  def prod([]), do: 1
  def prod([head | tail]), do: N.mult(prod(head), prod(tail)) |> CH.make_real
  def prod(number), do: number

end

