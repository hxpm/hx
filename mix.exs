defmodule Hx.MixProject do
  use Mix.Project

  def project do
    [
      app: :hx,
      version: "0.0.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Hx.Application, []}
    ]
  end

  defp deps do
    [
      {:dialyxir, "~> 1.3", only: :dev, runtime: false},
      {:ex_doc, "~> 0.29", only: :dev, runtime: false}
    ]
  end
end
