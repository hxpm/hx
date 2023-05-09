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
# oban
#

config :hx, Oban, testing: :inline
