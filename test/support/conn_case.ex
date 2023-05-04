defmodule HxWeb.ConnCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      @endpoint HxWeb.Endpoint
    end
  end

  setup tags do
    Hx.DataCase.setup_sandbox(tags)

    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end
end
