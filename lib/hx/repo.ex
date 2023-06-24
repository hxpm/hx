defmodule Hx.Repo do
  @moduledoc """
  `Ecto.Repo` for the Hx platform.
  """

  use Ecto.Repo,
    adapter: Ecto.Adapters.Postgres,
    otp_app: :hx

  @impl true
  def init(:runtime, config) do
    Hx.StartTimeConfig.start_link([])

    config =
      config
      |> init()
      |> Keyword.put(:pool_size, 2)

    {:ok, config}
  end

  def init(_, config) do
    {:ok, init(config)}
  end

  @spec init(Keyword.t()) :: Keyword.t()
  def init(config) do
    config
    |> Keyword.put(:pool_size, Hx.StartTimeConfig.get(:database_pool_size))
    |> Keyword.put(:url, Hx.StartTimeConfig.get(:database_url))
  end
end
