import Config

#
# phoenix
#

config :hx, HxWeb.Endpoint,
  watchers: [
    esbuild: {Esbuild, :install_and_run, [:default, ~w(--sourcemap=inline --watch)]},
    npx: [
      "tailwindcss",
      "-i",
      "assets/css/hx.css",
      "-o",
      "priv/static/assets/css/hx.css",
      "--watch"
    ]
  ]
