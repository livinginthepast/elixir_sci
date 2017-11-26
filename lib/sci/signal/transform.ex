defmodule Sci.Signal.Transform do
  @moduledoc """
  The entrypoint for signal transformations.
  """

  alias Sci.Signal.Transform.Bilinear

  @doc """
  Transforms an analog signal filter to a digital filter. This transforms the
  continuous-time system to a discrete-time representation.

  ## Examples

      iex> Sci.Signal.Transform.bilinear([], [2, 3, 4, 5], 1.3, 2.0)
      {[-1, -1, -1, -1], [-3.0, -2.0, -1.6666666666666667, -1.5], 0.05416666666666667}

      iex> Sci.Signal.Transform.bilinear([2, 3, 4], [2, 3, 4, 5], 1.3, 2.0)
      {[-3.0, -2.0, -1.6666666666666667, -1], [-3.0, -2.0, -1.6666666666666667, -1.5], -0.325}

  """
  defdelegate bilinear(zeros, poles, gain, sampling_frequency), to: Bilinear, as: :transform

end
