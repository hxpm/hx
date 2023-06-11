defmodule Hx.Repo.Migrations.CreateSystemSettingsTable do
  use Ecto.Migration

  def change do
    create table(:system_settings) do
      add :key, :string

      add :value, :string

      timestamps()
    end

    create index(:system_settings, :key, unique: true)
  end
end
