defmodule Sci.Helpers.ComplexHelpers do
  @moduledoc """
  Helpers for dealing with complex numbers. Wraps the ComplexNum package.
  """

  alias ComplexNum.Cartesian, as: C

  @doc """
  Make a complex number real if its imaginary component is 0.

  ## Examples

      iex> Sci.Helpers.ComplexHelpers.make_real(1)
      1

      iex> import Sci.Helpers.Sigils
      iex> Sci.Helpers.ComplexHelpers.make_real(~n{2+2i})
      ComplexNum.new(2, 2)

      iex> import Sci.Helpers.Sigils
      iex> Sci.Helpers.ComplexHelpers.make_real(~n{3+0i})
      3

  """
  def make_real(%ComplexNum{mode: ComplexNum.Cartesian} = number) do
    if real?(number) do
      C.real(number)
    else
      number
    end
  end
  def make_real(number), do: number

  @doc """
  Determines whether a number is real, or a set of numbers is entirely composed
  of real numbers. True for a `ComplexNum` where the imaginary component is 0.

  ## Examples

      iex> Sci.Helpers.ComplexHelpers.real?(123)
      true

      iex> Sci.Helpers.ComplexHelpers.real?([123, 456])
      true

      iex> Sci.Helpers.ComplexHelpers.real?(ComplexNum.new(1))
      true

      iex> Sci.Helpers.ComplexHelpers.real?(ComplexNum.new(1, 1))
      false

      iex> Sci.Helpers.ComplexHelpers.real?([ComplexNum.new(1, 0), ComplexNum.new(2, -0.234)])
      false

  """
  def real?(set) when is_list(set), do: set |> Enum.all?(&real?/1)
  def real?(%ComplexNum{} = num), do: C.imaginary(num) == 0
  def real?(x) when is_number(x), do: true
end
