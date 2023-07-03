defmodule Hx.Config.EnvStore do
  @moduledoc """
  Configuration store that uses environment variables for its repository.
  """

  @behaviour Hx.Config.Store

  @impl true
  def all(opts) do
    Enum.reduce(opts[:config_keys], {:ok, []}, fn
      key, {:ok, acc} ->
        {:ok, Keyword.put(acc, key, get(key))}
    end)
  end

  @doc """
  Returns the value of the environment variable corresponding to the given key.
  """
  @spec get(atom) :: String.t()
  def get(key) do
    key
    |> to_env()
    |> System.get_env()
  end

  @doc """
  Converts a configuration key to it's corresponding environment variable.
  """
  @spec to_env(atom) :: String.t()
  def to_env(key) do
    "HX_" <> (key |> to_string() |> String.upcase())
  end
end
