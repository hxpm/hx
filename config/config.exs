import Config

config :hx, ecto_repos: [Hx.Repo]

# # #

import_config "#{config_env()}.exs"
