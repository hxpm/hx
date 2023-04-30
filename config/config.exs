import Config

#
# ecto
#

config :hx, ecto_repos: [Hx.Repo]

#
# esbuild
#

config :esbuild,
  default: [
    args: [
      "js/hx.js",
      "--bundle",
      "--outdir=../priv/static/assets",
      "--target=es2022"
    ],
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ],
  version: "0.17.18"

#
# logger
#

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

#
# oban
#

config :hx, Oban,
  notifier: Oban.Notifiers.PG,
  peer: Oban.Peers.Global,
  plugins: [
    Oban.Plugins.Gossip,
    Oban.Plugins.Lifeline,
    Oban.Plugins.Pruner
  ],
  queues: [],
  repo: Hx.Repo

#
# phoenix
#

config :hx, HxWeb.Endpoint,
  adapter: Bandit.PhoenixAdapter,
  server: true

config :phoenix, :json_library, Jason

# # #

import_config "#{config_env()}.exs"
