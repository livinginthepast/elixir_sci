defmodule Test.ComplexHelpers do
  def complex(real), do: complex(r: real, i: 0)
  def complex(r: real, i: imag), do: ComplexNum.new(real, imag)
end
