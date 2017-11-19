defmodule Test.ComplexHelpers do
  def complex(r: %ComplexNum{} = real), do: real
  def complex(r: real), do: complex(r: real, i: 0)
  def complex(r: real, i: imag), do: ComplexNum.new(real, imag)
  def complex(real), do: ComplexNum.new(real, 0)
end
