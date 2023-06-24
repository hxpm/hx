defmodule Hx.Supervisor do
  @moduledoc false

  use Supervisor

  @spec start_link :: Supervisor.on_start()
  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  @impl true
  def init(:ok) do
    Supervisor.init(children(), strategy: :one_for_one)
  end

  defp children do
    [
      {Hx.StartTimeConfig, []},
      {Hx.Repo, []},
      {Hx.Oban, []},
      {Hx.PubSub, []},
      {HxWeb.Endpoint, []}
    ]
  end
end
