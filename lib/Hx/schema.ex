defmodule Hx.Schema do
  @moduledoc """
  Used to extend an Ecto schema with defaults sensible to Hx.

  `Hx.Schema` sets the default timestamps type to `:utc_datetime_usec`. Use this
  in place of `Ecto.Schema` for all repository backed schemas. Continue using
  `Ecto.Schema` for embedded schemas.
  """

  defmacro __using__(_opts) do
    quote do
      use Ecto.Schema

      @timestamps_opts [type: :utc_datetime_usec]
    end
  end
end
