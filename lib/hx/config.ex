defmodule Hx.Config do
  @moduledoc """
  Provides access to application runtime configuration.
  """

  use GenServer

  require Logger

  @keys [:database_pool_size, :database_url]

  @doc """
  Retrieves the value of a configuration option for the given key.
  """
  @spec get(module, atom) :: any
  def get(server \\ __MODULE__, key) do
    GenServer.call(server, {:get, key})
  end

  @doc """
  Loads configuration from the OS environment and returns a map of the values.
  """
  @spec load :: {:ok, map} | {:error, String.t()}
  def load do
    Enum.reduce(@keys, {:ok, %{}}, fn
      key, {:ok, config} ->
        value =
          key
          |> to_env()
          |> System.get_env()

        case load(key, value) do
          {:ok, value} ->
            {:ok, Map.put(config, key, value)}

          {:error, message} ->
            {:error, "#{to_env(key)} #{message}"}
        end

      _, acc ->
        acc
    end)
  end

  @doc """
  Performs any validation and type conversion needed to load a configuration
  option.
  """
  @spec load(atom, any) :: Hx.Config.Loader.loaded_t()
  def load(:database_pool_size, value) do
    Hx.Config.PositiveIntegerLoader.load(value, 10)
  end

  def load(:database_url, value) do
    Hx.Config.RequiredLoader.load(value)
  end

  def load(_key, value) do
    {:ok, value}
  end

  @spec start_link(keyword) :: GenServer.on_start()
  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, name: opts[:name] || __MODULE__)
  end

  @doc """
  Converts a key to it's corresponding environment variable.

  ## Example

      iex> Hx.Config.to_env(:database_url)
      "HX_DATABASE_URL"
  """
  @spec to_env(atom) :: String.t()
  def to_env(key) do
    "HX_" <> (key |> to_string() |> String.upcase())
  end

  @impl true
  def init(:ok) do
    case load() do
      {:ok, config} ->
        {:ok, config}

      {:error, message} ->
        Logger.error("Failed to load configuration. #{message}.")

        System.stop(1)
    end
  end

  @impl true
  def handle_call({:get, key}, _from, config) do
    {:reply, config[key], config}
  end
end
