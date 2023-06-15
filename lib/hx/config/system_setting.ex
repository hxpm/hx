defmodule Hx.Config.SystemSetting do
  @moduledoc """
  System configuration setting.
  """

  use Hx.Schema

  @type t ::
          %__MODULE__{
            __meta__: Ecto.Schema.Metadata.t(),
            inserted_at: nil | DateTime.t(),
            key: nil | String.t(),
            updated_at: nil | DateTime.t(),
            value: nil | String.t()
          }

  @primary_key {:key, :string, []}

  schema "system_settings" do
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
  Attempts to create a system setting. If a setting with the provided key
  already exists, it will be updated instead.
  """
  @spec create_or_update!(String.t(), String.t()) :: t | no_return
  def create_or_update!(key, value) do
    %__MODULE__{}
    |> Ecto.Changeset.cast(%{key: key, value: value}, [:key, :value])
    |> Ecto.Changeset.validate_required(:key)
    |> Ecto.Changeset.validate_required(:value)
    |> Hx.Repo.insert!(conflict_target: :key, on_conflict: {:replace, [:value]})
  end
end
