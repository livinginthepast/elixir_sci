defmodule Sci.Polynomial.Poly do
  @moduledoc false

  import ComplexNum.Cartesian, only: [imaginary: 1, real: 1]

  def poly([]), do: [1]
  def poly(set) when is_list(set) do
    zeros = set |> zeros()
    zeros
    |> Stream.with_index()
    |> Enum.reduce(zeros, &(find_coefficients(&1, &2, set)))
    |> make_real(set)
  end

  defp find_coefficients({_zero, 0}, accumulator, _set), do: accumulator
  defp find_coefficients({_zero, index}, accumulator, set) do
    accumulator
    |> Stream.with_index()
    |> Enum.map(&(iterate(&1, accumulator, set |> Enum.at(index - 1))))
  end

  defp iterate({%ComplexNum{} = acc, 0}, _accumulator, _value), do: acc
  defp iterate({acc, 0}, _accumulator, %ComplexNum{} = _value), do: ComplexNum.new(acc)
  defp iterate({acc, 0}, _accumulator, _value), do: acc
  defp iterate({acc, index}, accumulator, %ComplexNum{} = value) do
    ComplexNum.sub(acc, ComplexNum.mult(value, (accumulator |> Enum.at(index - 1))))
  end
  defp iterate({acc, index}, accumulator, value) do
    acc - value * (accumulator |> Enum.at(index - 1))
  end

  defp make_real(coefficients, set) do
    case set |> Enum.map(&imaginary/1) |> Enum.all?(fn x -> x == 0 end) do
      true -> coefficients |> Enum.map(&real/1)
      false -> coefficients
    end
  end

  defp zeros(set) do
    [1 | List.duplicate(0, length(set)) ]
  end
end
