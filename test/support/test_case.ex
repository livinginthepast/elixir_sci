defmodule Sci.TestCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      import ComplexNumSigil
    end
  end
end
