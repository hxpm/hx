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
      {:bandit, "~> 0.7"},
      {:ecto, "~> 3.10"},
      {:ecto_sql, "~> 3.10"},
      {:jason, "~> 1.4"},
      {:oban, "~> 2.15"},
      {:phoenix, "~> 1.7"},
      {:phoenix_html, "~> 3.3"},
      {:phoenix_live_view, "~> 0.18"},
      {:postgrex, "~> 0.17"},

      #
      # dev
      #

      {:dialyxir, "~> 1.3", only: :dev, runtime: false},
      {:ex_doc, "~> 0.29", only: :dev, runtime: false}
    ]
  end
end
