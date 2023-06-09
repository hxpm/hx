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
      {:argon2_elixir, "3.1.0"},
      {:bandit, "0.7.7"},
      {:ecto, "== 3.10.3"},
      {:ecto_sql, "3.10.1"},
      {:esbuild, "== 0.7.1", runtime: Mix.env() == :dev},
      {:gettext, "== 0.22.3"},
      {:jason, "== 1.4.1"},
      {:oban, "== 2.15.2"},
      {:phoenix, "== 1.7.7"},
      {:phoenix_ecto, "== 4.4.2"},
      {:phoenix_html, "3.3.1"},
      {:phoenix_live_view, "== 0.19.4"},
      {:phoenix_pubsub, "== 2.1.3"},
      {:postgrex, "== 0.17.2"},

      #
      # dev
      #

      {:dialyxir, "1.3.0", only: :dev, runtime: false},
      {:ex_doc, "== 0.30.2", only: :dev, runtime: false},
      {:phoenix_live_reload, "1.4.1", only: :dev},

      #
      # test
      #

      {:floki, "== 0.34.3", only: :test}
    ]
  end

  defp elixirc_paths(:test) do
    ["lib", "test/support"]
  end

  defp elixirc_paths(_env) do
    ["lib"]
  end
end
