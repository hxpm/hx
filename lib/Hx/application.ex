defmodule Hx.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    Hx.Supervisor.start_link()
  end
end
