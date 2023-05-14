defmodule Hx.PubSub do
  @moduledoc false

  @spec child_spec(Keyword.t()) :: Supervisor.child_spec()
  def child_spec(_) do
    [name: __MODULE__]
    |> Phoenix.PubSub.child_spec()
    |> Supervisor.child_spec([])
  end
end
