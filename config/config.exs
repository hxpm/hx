import Config

#
# ecto
#

config :hx, ecto_repos: [Hx.Repo]

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

# # #

import_config "#{config_env()}.exs"
