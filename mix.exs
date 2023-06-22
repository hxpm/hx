defmodule Hx.MixProject do
  use Mix.Project

  def project do
    [
      app: :hx,
      version: "0.0.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env())
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
      {:argon2_elixir, "~> 3.1"},
      {:bandit, "~> 0.7"},
      {:ecto, "~> 3.10"},
      {:ecto_sql, "~> 3.10"},
      {:esbuild, "~> 0.7", runtime: Mix.env() == :dev},
      {:gettext, "~> 0.22"},
      {:jason, "~> 1.4"},
      {:oban, "~> 2.15"},
      {:phoenix, "~> 1.7"},
      {:phoenix_ecto, "~> 4.4"},
      {:phoenix_html, "~> 3.3"},
      {:phoenix_live_view, "~> 0.19"},
      {:phoenix_pubsub, "~> 2.1"},
      {:postgrex, "~> 0.17"},

      #
      # dev
      #

      {:dialyxir, "~> 1.3", only: :dev, runtime: false},
      {:ex_doc, "~> 0.29", only: :dev, runtime: false},
      {:phoenix_live_reload, "~> 1.4", only: :dev},

      #
      # test
      #

      {:floki, "~> 0.34", only: :test}
    ]
  end

  defp elixirc_paths(:test) do
    ["lib", "test/support"]
  end

  defp elixirc_paths(_env) do
    ["lib"]
  end
end
