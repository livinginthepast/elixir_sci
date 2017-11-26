defmodule Sci.Signal.Transform.Bilinear do
  alias Numbers, as: N
  alias Sci.Helpers.ComplexHelpers, as: CH
  alias Sci.List, as: L

  @spec transform(List.t, List.t, float, float) :: {List.t, List.t, float}
  def transform(zeros, poles, gain, sample_rate)
  def transform(z, p, _, _) when length(p) < length(z), do: raise "length of zeros cannot exceed length of poles"
  def transform(zeros, poles, gain, sample_rate) when is_list(zeros) and is_list(poles) and is_float(gain) and is_float(sample_rate) do
    {
      bilinear_zeros(zeros, poles, sample_rate),
      bilinear_poles(poles, sample_rate),
      bilinear_gain(zeros, poles, gain, sample_rate)
    }
  end

  defp bilinear_zeros([], poles, _sample_rate), do: -1 |> List.duplicate(length(poles))
  defp bilinear_zeros(zeros, poles, sample_rate) do
    transform_set(zeros, sample_rate) ++ (-1 |> List.duplicate(length(poles) - length(zeros)))
  end

  defp bilinear_poles(poles, sample_rate) do
    transform_set(poles, sample_rate)
  end

  defp bilinear_gain(zeros, poles, gain, sample_rate) do
    zeros = zeros |> Enum.map(&(gain_tranform_fun(&1, sample_rate))) |> L.prod
    poles = poles |> Enum.map(&(gain_tranform_fun(&1, sample_rate))) |> L.prod

    N.mult(gain, N.div(zeros, poles) |> CH.make_real(force: true))
  end

  defp transform_set(set, sample_rate) do
    numerator = set |> Enum.map(fn value -> value |> N.mult(sample_rate) |> N.add(2) end)
    denominator = set |> Enum.map(fn value -> N.sub(2, (value |> N.mult(sample_rate))) end)

    numerator |> L.div(denominator)
  end

  defp gain_tranform_fun(value, sample_rate) do
    N.sub(2, N.mult(value, sample_rate)) |> N.div(sample_rate)
  end
end
