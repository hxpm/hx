defmodule HxWeb.Endpoint do
  @moduledoc """
  `Phoenix.Endpoint` for the Hx application.
  """

  use Phoenix.Endpoint, otp_app: :hx

  @session_opts [
    http_only: true,
    key: "_hx_session",
    same_site: "Lax",
    signing_salt: {Hx.Config, :get, [:signing_salt]},
    store: :cookie
  ]

  #
  # code reloading
  #

  if code_reloading? do
    plug Phoenix.CodeReloader

    plug Phoenix.Ecto.CheckRepoStatus, otp_app: :hx

    plug Phoenix.LiveReloader

    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
  end

  #
  # plugs
  #

  plug Plug.Parsers,
    parsers: [:json, :multipart, :urlencoded],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.RequestId

  plug Plug.Session, @session_opts

  plug Plug.Static,
    at: "/",
    from: :hx,
    gzip: false,
    only: HxWeb.static_paths()

  plug HxWeb.Router

  #
  # sockets
  #

  socket "/live", Phoenix.LiveView.Socket,
    websocket: [
      connect_info: [
        session: @session_opts
      ]
    ]

  #
  # callbacks
  #

  @impl true
  def init(_, config) do
    config =
      config
      |> Keyword.put(:http, port: Hx.StartTimeConfig.get(:port))
      |> Keyword.put(:live_view, signing_salt: Hx.StartTimeConfig.get(:signing_salt))
      |> Keyword.put(:secret_key_base, Hx.StartTimeConfig.get(:secret_key))

    {:ok, config}
  end
end
