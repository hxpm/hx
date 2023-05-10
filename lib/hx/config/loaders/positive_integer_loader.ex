defmodule Hx.Config.PositiveIntegerLoader do
  @moduledoc """
  Configuration loader for validating that the provided value is a positive
  integer and converting it to an integer if validation is successful.
  """

  @behaviour Hx.Config.Loader

  @impl true
  def load(value) do
    load(value, nil)
  end

  @doc """
  Behaves exactly like `c:Hx.Config.Loader.load/1` but also accepts a default
  value as its third argument. If the provided value is either `nil` or an
  empty string, the default value will be returned. If no default value is
  provided `nil` will be returned.
  """
  @spec load(String.t(), pos_integer | nil) ::
          Hx.Config.Loader.loaded_t()
  def load(value, default) do
    if is_nil(value) || value == "" do
      {:ok, default}
    else
      case Integer.parse(value) do
        {parsed_value, ""} when parsed_value > 0 ->
          {:ok, parsed_value}

        _ ->
          {:error, "must be a positive integer"}
      end
    end
  end
end
