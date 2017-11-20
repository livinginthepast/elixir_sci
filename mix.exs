defmodule Sci.Mixfile do
  use Mix.Project

  def project do
    [
      app: :sci,
      version: "0.0.2",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env),
      start_permanent: Mix.env == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      source_url: "https://github.com/livinginthepast/elixir_sci",
    ]
  end

  def application do
    []
  end

  defp deps do
    [
      {:complex_num, "~> 1.1"},
      {:ex_doc, ">= 0.0.0", only: :dev},
    ]
  end

  defp description() do
    """
    Scientific computation for Elixir. This package contains ports of functions
    used for scientific computation and signal processing.

    This package is a work in progress, and may only partially implement
    certain functions. Contributions are welcome.
    """
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp package() do
    [
      licenses: ["MIT"],
      maintainers: ["Eric Saxby"],
      links: %{"GitHub" => "https://github.com/livinginthepast/elixir_sci"},
    ]
  end
end
