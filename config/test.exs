import Config

#
# ecto
#

config :hx, Hx.Repo, pool: Ecto.Adapters.SQL.Sandbox

#
# oban
#

config :hx, Oban, testing: :inline
