defmodule HxWeb.HTML do
  @moduledoc """
  Defines an HTML view.
  """

  defmacro __using__(_opts) do
    quote do
      use Phoenix.Component

      use Phoenix.VerifiedRoutes,
        endpoint: HxWeb.Endpoint,
        router: HxWeb.Router,
        statics: HxWeb.static_paths()

      import Phoenix.Controller,
        only: [
          get_csrf_token: 0
        ]
    end
  end
end
