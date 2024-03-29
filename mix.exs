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
      {:argon2_elixir, "== 4.0.0"},
      {:bandit, "== 1.2.0"},
      {:ecto, "== 3.11.1"},
      {:ecto_sql, "== 3.11.1"},
      {:esbuild, "== 0.8.1", runtime: Mix.env() == :dev},
      {:gettext, "== 0.24.0"},
      {:jason, "== 1.4.1"},
      {:oban, "== 2.17.3"},
      {:phoenix, "== 1.7.10"},
      {:phoenix_ecto, "== 4.4.3"},
      {:phoenix_html, "== 4.0.0"},
      {:phoenix_live_view, "== 0.20.3"},
      {:phoenix_pubsub, "== 2.1.3"},
      {:postgrex, "== 0.17.4"},

      #
      # dev
      #

      {:dialyxir, "== 1.4.3", only: :dev, runtime: false},
      {:ex_doc, "== 0.31.1", only: :dev, runtime: false},
      {:phoenix_live_reload, "1.4.1", only: :dev},

      #
      # test
      #

      {:floki, "== 0.35.3", only: :test}
    ]
  end

  defp elixirc_paths(:test) do
    ["lib", "test/support"]
  end

  defp elixirc_paths(_env) do
    ["lib"]
  end
end
