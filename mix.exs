defmodule Aoc2020Elixir.MixProject do
  use Mix.Project

  def project do
    [
      app: :aoc_2020_elixir,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:mix_test_interactive, "~> 1.0", only: :dev, runtime: false},
      {:ex_parameterized, "~> 1.3.7"}
    ]
  end

end
