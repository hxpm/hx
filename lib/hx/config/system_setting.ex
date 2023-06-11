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

  @doc """
  Returns all system settings.
  """
  @spec all :: [t]
  def all do
    Hx.Repo.all(__MODULE__)
  end

  @doc """
  Creates a system setting.
  """
  @spec create!(String.t(), String.t()) :: t
  def create!(key, value) do
    %__MODULE__{}
    |> Ecto.Changeset.cast(%{key: key, value: value}, [:key, :value])
    |> Ecto.Changeset.validate_required(:key)
    |> Ecto.Changeset.unique_constraint(:key)
    |> Ecto.Changeset.validate_required(:value)
    |> Hx.Repo.insert!()
  end
end
