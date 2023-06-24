defmodule Hx.StartTimeConfig do
  @moduledoc """
  Manages access to configuration needed at application start-time.

  Start-time configuration is a minimum set of configuration needed to start
  the application. These are static values that are required to be set before
  application start and cannot be changed at runtime.

  Values are read from environment variables and stored in-memory for quick and
  easy access. Environment variable names are derived from the supported
  configuration keys. Each environment variable is comprised of an `HX_` prefix
  followed by the uppercased configuration key. For example, the
  `:database_pool_size` configuration key is read from the
  `HX_DATABASE_POOL_SIZE` environment variable.
  """

  use GenServer

  require Logger

  @keys [
    :database_pool_size,
    :database_url,
    :port,
    :secret_key,
    :signing_salt
  ]

  @doc """
  Returns a configuration value for the provided key.
  """
  @spec get(module, atom) :: any
  def get(server \\ __MODULE__, key) do
    GenServer.call(server, {:get, key})
  end

  @doc """
  Returns a map of start-time configuration.

  Values may be validated and/or coerced into a type. If a value is invalid, an
  error will be returned.
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

  @spec load(atom, any) :: Hx.Config.Loader.loaded_t()
  defp load(:database_pool_size, value) do
    Hx.Config.PositiveIntegerLoader.load(value, 10)
  end

  defp load(:database_url, value) do
    Hx.Config.RequiredLoader.load(value)
  end

  defp load(:port, value) do
    Hx.Config.PositiveIntegerLoader.load(value, 4000)
  end

  defp load(:secret_key, value) do
    Hx.Config.RequiredLoader.load(value)
  end

  defp load(:signing_salt, value) do
    Hx.Config.RequiredLoader.load(value)
  end

  defp load(_key, value) do
    {:ok, value}
  end

  @spec start_link(keyword) :: GenServer.on_start()
  def start_link(opts) do
    opts = Keyword.put_new(opts, :name, __MODULE__)

    GenServer.start_link(__MODULE__, opts, name: opts[:name])
  end

  @doc """
  Converts a configuration key to it's corresponding environment variable.
  """
  @spec to_env(atom) :: String.t()
  def to_env(key) do
    "HX_" <> (key |> to_string() |> String.upcase())
  end

  @impl true
  def init(_opts) do
    case load() do
      {:ok, config} ->
        {:ok, config}

      {:error, message} ->
        error = "Failed to load configuration. #{message}."

        Logger.error(error)

        System.stop(1)

        {:stop, error}
    end
  end

  @impl true
  def handle_call({:get, key}, _from, config) do
    {:reply, config[key], config}
  end
end
