import Config

#
# phoenix
#

config :hx, HxWeb.Endpoint,
  code_reloader: true,
  live_reload: [
    patterns: [
      ~r"priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"lib/hx_web/(components|controllers|live)/.*(ex|heex)$"
    ]
  ],
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
