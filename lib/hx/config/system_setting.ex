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
            id: nil | integer,
            inserted_at: nil | DateTime.t(),
            key: nil | String.t(),
            updated_at: nil | DateTime.t(),
            value: nil | String.t()
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

  @spec cast(t, map, for: :insert) :: Ecto.Changeset.t()
  def cast(system_setting, props, for: :insert) do
    Ecto.Changeset.cast(system_setting, props, [:key, :value])
  end

  @doc """
  Creates a system setting.
  """
  @spec create!(String.t(), String.t()) :: t | no_return
  def create!(key, value) do
    %__MODULE__{}
    |> cast(%{key: key, value: value}, for: :insert)
    |> validate_key()
    |> validate_value()
    |> Hx.Repo.insert!()
  end

  @doc """
  Validates that `:key` is required and unique.
  """
  @spec validate_key(Ecto.Changeset.t()) :: Ecto.Changeset.t()
  def validate_key(changeset) do
    changeset
    |> Ecto.Changeset.validate_required(:key)
    |> Ecto.Changeset.unique_constraint(:key)
  end

  @doc """
  Validates that `:value` is required.
  """
  @spec validate_value(Ecto.Changeset.t()) :: Ecto.Changeset.t()
  def validate_value(changeset) do
    Ecto.Changeset.validate_required(changeset, :value)
  end
end
