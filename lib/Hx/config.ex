defmodule Hx.Config do
  @moduledoc """
  Provides access to application runtime configuration.
  """

  use GenServer

  require Logger

  @keys [:database_url]

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
  @spec load :: map
  def load do
    Enum.reduce(@keys, %{}, fn
      key, acc ->
        env = to_env(key)

        value = System.get_env(env)

        Map.put(acc, key, value)
    end)
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

  @doc """
  Validates the provided configuration map against all configuration options.
  Returns `:ok` if the configuration is valid. Otherwise, `{:error, String.t()}`
  is returned.
  """
  @spec validate(map) :: :ok | {:error, String.t()}
  def validate(config) do
    Enum.reduce(@keys, :ok, fn
      key, :ok ->
        validate(config, key)

      _, acc ->
        acc
    end)
  end

  @doc """
  Validates individual configuration options. Returns `:ok` if the configuration
  is valid. Otherwise, `{:error, String.t()}` is returned.
  """
  @spec validate(map, atom) :: :ok | {:error, String.t()}
  def validate(config, :database_url = key) do
    case config[key] do
      value when is_nil(value) or value == "" ->
        {:error, "#{to_env(key)} is required."}

      _ ->
        :ok
    end
  end

  def validate(_, _) do
    :ok
  end

  @impl true
  def init(:ok) do
    config = load()

    case validate(config) do
      :ok ->
        {:ok, config}

      {:error, message} ->
        Logger.error("Failed to load configuration. #{message}")

        System.stop(1)
    end
  end

  @impl true
  def handle_call({:get, key}, _from, config) do
    {:reply, config[key], config}
  end
end
