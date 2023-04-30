defmodule Hx.Config.RequiredLoader do
  @moduledoc """
  Configuration loader that ensures the provided value is not `nil` or an empty
  string.
  """

  @behaviour Hx.Config.Loader

  @impl true
  def load(value) do
    if is_nil(value) || value == "" do
      {:error, "is required"}
    else
      {:ok, value}
    end
  end
end
