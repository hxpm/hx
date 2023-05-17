import Config

#
# phoenix
#

config :hx, HxWeb.Endpoint,
  watchers: [
    esbuild: {Esbuild, :install_and_run, [:default, ~w(--sourcemap=inline --watch)]},
    npx: [
      "tailwindcss",
      "-c",
      "assets/tailwind.config.js",
      "-i",
      "assets/css/hx.css",
      "-o",
      "priv/static/assets/hx.css",
      "--watch"
    ]
  ]
