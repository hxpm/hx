defmodule Hx.Config.SystemSetting do
  @moduledoc """
  System configuration setting.

  A system setting does not need to be known before application start. This
  type of configuration can be dynamic and change during runtime.
  """

  use Hx.Schema

  @type t ::
          %__MODULE__{
            __meta__: Ecto.Schema.Metadata.t(),
            id: integer,
            inserted_at: DateTime.t(),
            key: String.t(),
            updated_at: DateTime.t(),
            value: String.t()
          }

  schema "system_settings" do
    field :key, :string

    field :value, :string

    timestamps()
  end
end
