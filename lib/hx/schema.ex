defmodule Hx.Schema do
  @moduledoc """
  Defines an Ecto schema.

  Sets the default timestamps type to `:utc_datetime`. Use this in place of
  `Ecto.Schema` for all repository backed schemas. Continue using `Ecto.Schema`
  for embedded schemas.
  """

  defmacro __using__(_opts) do
    quote do
      use Ecto.Schema

      @timestamps_opts [type: :utc_datetime]
    end
  end
end
