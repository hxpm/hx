import Config

#
# argon2_elixir
#

config :argon2_elixir,
  m_cost: 8,
  t_cost: 1

#
# ecto
#

config :hx, Hx.Repo,
  log: false,
  pool: Ecto.Adapters.SQL.Sandbox

#
# logger
#

config :logger, level: :warning

#
# oban
#

config :hx, Oban, testing: :inline

#
# phoenix
#

config :hx, HxWeb.Endpoint, server: false
