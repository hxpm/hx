defmodule Hx.Oban do
  @moduledoc false

  @config Application.compile_env!(:hx, Oban)

  @spec child_spec(Keyword.t()) :: Supervisor.child_spec()
  def child_spec(_) do
    @config
    |> Oban.child_spec()
    |> Supervisor.child_spec([])
  end
end
