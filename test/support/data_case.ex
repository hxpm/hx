defmodule Hx.DataCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias Hx.Repo

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import Hx.DataCase
    end
  end

  setup tags do
    Hx.DataCase.setup_sandbox(tags)
    :ok
  end

  def setup_sandbox(tags) do
    pid = Ecto.Adapters.SQL.Sandbox.start_owner!(Hx.Repo, shared: not tags[:async])

    on_exit(fn ->
      Ecto.Adapters.SQL.Sandbox.stop_owner(pid)
    end)
  end
end
