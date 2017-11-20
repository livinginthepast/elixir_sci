defmodule Sci.Helpers.Sigils do
  @doc """
  Handles the sigil `~n`

  Parses the number into a ComplexNum.

  ## Examples

      iex> ~n{1}
      ComplexNum.new(1)

      iex> ~n{0.1+12i}
      ComplexNum.new(0.1, 12)

      iex> ~n{0.1-0.12e-12i}
      ComplexNum.new(0.1, -0.12e-12)

      iex> ~n{1.1+3.12e-12i}
      ComplexNum.new(1.1, 3.12e-12)

  """
  def sigil_n(complex, []) do
    case Regex.match?(~r/^(\-?[\d\.]+(e\-?\d+)?)\+?(\-?[\d\.]+(e\-?\d+)?i)?$/, complex) do
      true -> parse_complex(complex)
      _ -> raise "Unable to match complex number of format ~n{0.123±01245i}"
    end
  end

  defp parse_complex(string) do
    case parse_component(string) do
      {real, ""} -> ComplexNum.new(real, 0)
      {real, tail} ->
        {imaginary, _} = parse_component(tail)
        ComplexNum.new(real, imaginary)
    end
  end

  defp parse_component(string) do
    if Regex.match?(~r/^[\+\-]?\d+\.\d+/, string) do #Integer.parse(string) do
      Float.parse(string)
    else
      Integer.parse(string)
    end
  end
end
