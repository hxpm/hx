defmodule Hx.Config.Loader do
  @moduledoc """
  Behaviour for defining a configuration loader.
  """

  @type loaded_t ::
          {:ok, any} | {:error, String.t()}

  @doc """
  Responsible for validating and coercing a configuration value. Returns
  `{:ok, any}` if the value is valid and was able to be converted to its
  expected type. If the value is invalid then `{:error, String.t()}` is
  returned.
  """
  @callback load(value :: String.t()) ::
              loaded_t
end
