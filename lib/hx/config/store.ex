defmodule Hx.Config.Store do
  @moduledoc """
  Behaviour for accessing a configuration store.

  A configuration store is a repository that holds configuration key/value
  pairs. A store is responsible for loading configuration from the underlying
  repository and giving that configuration to a provider so it can be processed
  and stored in-memory.
  """

  @doc """
  Callback that returns all configuration key/value pairs from a store.
  """
  @callback all(opts :: keyword) :: {:ok, keyword} | {:error, String.t()}

  @doc """
  Optional callback that adds or updates a configuration key/value pair to a
  store.
  """
  @callback put(key :: atom, value :: any, opts :: keyword) :: :ok

  @optional_callbacks put: 3
end
