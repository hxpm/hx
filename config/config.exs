import Config

#
# ecto
#

config :hx, ecto_repos: [Hx.Repo]

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
